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

class ViewPresenter: UIViewController, CLLocationManagerDelegate, OTPublisherDelegate, OTSessionDelegate {
    
    var session: OTSession?
    
    var locationManager: CLLocationManager?
    
    var sendingInfo = false
    var waitingResponse = false
    
    var APIURL = "http://6f4ca100.ngrok.com"
    
    var userId = ""
    var userFiringId = ""
    var userName = "Teste"
    var userMessage = "TO FUDIDO AQUI GG"
    
    var myView: ReadyView {
        
        get {
            return self.view as! ReadyView
        }
    }
    
    override func viewDidLoad() {
        
        self.view = ReadyView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
        
        let but = UIButton(frame: CGRectMake(100,100,100,50))
        but.setTitle("PANICO", forState: .Normal)
        but.addTarget(self, action: Selector("panic"), forControlEvents: .TouchUpInside)
        self.myView.addSubview(but)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func panic() {
        
        locationManager?.startUpdatingLocation()
        self.myView.backgroundColor = UIColor.redColor()
    }
    
    //STREAM
    
    func publisher(publisher: OTPublisherKit!, didFailWithError error: OTError!) {
        
        print("*******ERRO PUBLISH DID FAIL WITH ERROR")
        print(error)
    }
    
    //SESSION
    
    func sessionDidConnect(session: OTSession!) {
        
        let publisher = OTPublisher(delegate: self, name: "AudioStream", audioTrack: true, videoTrack: false)
        session.publish(publisher, error: nil)
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
    
    //MARK: LOCATION MANAGER
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let lat = locations[locations.count - 1].coordinate.latitude
        let lon = locations[locations.count - 1].coordinate.longitude
        
        var data = ["status": ["latitude": lat, "longitude": lon]] as [String: AnyObject]
        
        if(waitingResponse == true) {
            
            return
        }
        
        if(sendingInfo == false) {
            
            waitingResponse = true
            
            data = ["alert": ["name": userName, "contacts": [["name": "Joao Vicente", "number": "+5521996960420"]], "message": userMessage]]
            
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
        
        print("*******ERRO LOCATION MANAGER")
        print(error)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

