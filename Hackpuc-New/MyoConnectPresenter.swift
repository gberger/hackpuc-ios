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

class MyoConnectPresenter: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager?
    
    var sendingInfo = false
    var waitingResponse = false
    
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
    
    override func viewDidLoad() {
        
        self.view = MyoConnectView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func startPanic() {
        
        locationManager?.startUpdatingLocation()
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
