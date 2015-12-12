//
//  ViewController.swift
//  Hackpuc
//
//  Created by Joao Nassar Galante Guedes on 11/12/15.
//  Copyright © 2015 Grupo13. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class MyoConnectPresenter: UIViewController, CLLocationManagerDelegate, MyoViewProtocol, OTPublisherDelegate, OTSessionDelegate {
    
    var locationManager: CLLocationManager?
    
    var session: OTSession?
    var publisher: OTPublisher?
    
    var myo: [TLMMyo] = []
    
    var sendingInfo = false
    var waitingResponse = false
    var presented = false
    var begin = false
    var waiting = false
    
    var APIURL = "http://6f4ca100.ngrok.com"
    
    var userId = ""
    var userFiringId = ""
    var userName = "Pega nome do Usuário"
    var userMessage = "Pega mensagem do Usuário"
    
    var myView: MyoConnectView {
        
        get {
            return self.view as! MyoConnectView
        }
    }
    
    /******************************/
    //MARK: ViewController MANAGER
    /******************************/
    
    override func viewDidLoad() {
        
        self.view = MyoConnectView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
        self.myView.delegate = self
        
        let poseObserver = NSNotificationCenter.defaultCenter()
        poseObserver.addObserver(self, selector: Selector("didRecievePoseChange:"), name: TLMMyoDidReceivePoseChangedNotification, object: nil)
        
        let connectionObserver = NSNotificationCenter.defaultCenter()
        connectionObserver.addObserver(self, selector: Selector("connectionEvent:"), name: TLMHubDidConnectDeviceNotification, object: nil)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        let authorized = CLLocationManager.authorizationStatus()
        
        if(authorized == CLAuthorizationStatus.Restricted || authorized == CLAuthorizationStatus.Denied) {
            
            //Denied to use the position test
            
        } else {
            
            locationManager = CLLocationManager()
            locationManager?.requestAlwaysAuthorization()
            CLLocationManager.locationServicesEnabled()
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.distanceFilter = kCLDistanceFilterNone
            locationManager?.pausesLocationUpdatesAutomatically = false
            locationManager?.allowsBackgroundLocationUpdates = true
        }
    }
    
    /******************************/
    //MARK: OPENTOK MANAGER
    /******************************/
     
     //STREAM
    
    func publisher(publisher: OTPublisherKit!, didFailWithError error: OTError!) {
        
        print("*******ERRO PUBLISH DID FAIL WITH ERROR")
        print(error)
    }
    
    //SESSION
    
    func sessionDidConnect(session: OTSession!) {
        
        publisher = OTPublisher(delegate: self, name: "AudioStream", audioTrack: true, videoTrack: false)
        session.publish(publisher!, error: nil)
    }
    
    func sessionDidDisconnect(session: OTSession!) {
        
        print("AudioStream Disconnected")
    }
    
    func session(session: OTSession!, didFailWithError error: OTError!) {
        
        print("*******ERRO SESSION DID FAIL WITH ERROR")
        print(error)
    }
    
    func session(session: OTSession!, streamCreated stream: OTStream!) {
        
        print("Stream Created")
    }
    
    func session(session: OTSession!, streamDestroyed stream: OTStream!) {
        
        print("Stream Destroyed")
    }
    
    /******************************/
    //MARK: LOCATION MANAGER
    /******************************/
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let lat = locations[locations.count - 1].coordinate.latitude
        let lon = locations[locations.count - 1].coordinate.longitude
        
        var data = ["status": ["latitude": lat, "longitude": lon]] as [String: AnyObject]
        
        if(waitingResponse == true) {
            
            return
        }
        
        if(sendingInfo == false) {
            
            waitingResponse = true
            
            //Este array de contatos deve ser pego do realm. Deve-se colocar no array todos os contados que o usuário marcou como "quero enviar a mensagem"
            let contacts = [["name": "Joao Vicente", "number": "+5521995957897"],["name": "Joao Vicente", "number": "+5521995957897"]]
            
            data = ["alert": ["name": userName, "contacts": contacts, "message": userMessage]]
            
            Alamofire.request(.POST, APIURL + "/alerts", parameters: data, encoding: .JSON).responseJSON { response in
                
                let JSON = response.result.value as? [String: AnyObject]
                
                if JSON == nil {
                    
                    self.waitingResponse = false
                    return
                }
                
                let id = JSON!["id"] as? String
                
                if id == nil {
                    
                    self.waitingResponse = false
                    return
                }
                
                self.userId = id!
                
                Alamofire.request(.POST, self.APIURL + "/alerts/\(self.userId)/fire", parameters: data, encoding: .JSON).responseJSON { response in
                    
                    let JSON2 = response.result.value as? [String: AnyObject]
                    
                    if JSON2 == nil {
                        
                        self.waitingResponse = false
                        return
                    }
                    
                    let fire = JSON2!["firing"] as? [String: AnyObject]
                    
                    if fire == nil {
                        
                        self.waitingResponse = false
                        return
                    }
                    
                    let firingId = fire!["_id"] as? String
                    
                    if firingId == nil {
                        
                        self.waitingResponse = false
                        return
                    }
                    
                    let openTok = JSON2!["openTok"] as? [String: AnyObject]
                    
                    if openTok == nil {
                        
                        self.waitingResponse = false
                        return
                    }
                    
                    let sessionId = openTok!["sessionId"] as? String
                    
                    if sessionId == nil {
                        
                        self.waitingResponse = false
                        return
                    }
                    
                    let token = openTok!["token"] as? String
                    
                    if token == nil {
                        
                        self.waitingResponse = false
                        return
                    }
                    
                    self.session = OTSession(apiKey: "45435402", sessionId: sessionId, delegate: self)
                    self.session?.connectWithToken(token, error: nil)
                    
                    self.userFiringId = firingId!
                    self.waitingResponse = false
                    self.sendingInfo = true
                }
            }
            
        } else {
            
            let newURL = self.APIURL + "/alerts/\(self.userId)/fire/\(self.userFiringId)/status"
            
            Alamofire.request(.POST, newURL, parameters: data, encoding: .JSON)
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
        print(error)
    }
    
    func startPanic() {
        
        locationManager?.startUpdatingLocation()
        self.emergency()
    }
    
    /******************************/
    //MARK: Myo MANAGER
    /******************************/
    
    func connectMyo() {
        
        if !presented{
            
            let navigationController = TLMSettingsViewController.settingsInNavigationController() as UINavigationController
            self.presentViewController(navigationController, animated: true, completion: nil)
            presented = true
        }
    }
    
    func connectionEvent(notification: NSNotification){
        
        myo = TLMHub.sharedHub().myoDevices() as! [TLMMyo]
        self.myView.cInfo?.textColor = FPColor.gColor()
        self.myView.cInfo?.text = "Conectado"
        self.myView.labelInfo?.text = "Deixe o aplicativo nesta tela. Você pode minimizar o app e utilizar seu celular normalmente."
        self.myView.myo?.image = UIImage(named: "MyoOn.png")
    }
    
    func didRecievePoseChange(notification: NSNotification){
        
        var dict:Dictionary<String,TLMPose> = notification.userInfo as! Dictionary<String,TLMPose>
        
        let pose = dict[kTLMKeyPose]
        switch pose!.type {
            
        case TLMPoseType.DoubleTap :
            
            print("double")
            break;
            
        case TLMPoseType.FingersSpread:
            print("fingers")
            break;
            
        case TLMPoseType.Fist:
            print("fist")
            if !begin { self.startPanic() ; begin = true }
            if begin && waiting { self.userAnswered() ; waiting = false }
            break;
            
            
        case TLMPoseType.WaveIn:
            print("wavvein")
            
            break;
            
        case TLMPoseType.WaveOut:
            print("waveout")
            
            break;
            
        case TLMPoseType.Unknown:
            
            print("Unknown")
            break;
            
        default:
            break;
        }
    }
    
    func emergency() {
        print("fudeu")
        self.myo[0].vibrateWithLength(TLMVibrationLength.Short)
        
        delay(10, closure: {
            
            self.feedback()
        })
    }
    
    func feedback() {
        
        waiting = true
        
        self.myo[0].vibrateWithLength(TLMVibrationLength.Long)
        
        delay(10, closure: {
            
            if self.waiting {
                self.myo[0].vibrateWithLength(TLMVibrationLength.Long)
                self.userDidntAnswered()
                self.waiting = false
            }
        })
    }
    
    func userAnswered() {
        
        print("I'm fine")
        self.myo[0].vibrateWithLength(TLMVibrationLength.Short)
        delay(15, closure: {
            self.feedback()
        })
    }
    
    func userDidntAnswered() {
        
        print("send SMS")
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
}

