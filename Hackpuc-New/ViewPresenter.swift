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

class ViewPresenter: UIViewController, CLLocationManagerDelegate {
    
    var locationScanInterval = 4.0
    var locationManager: CLLocationManager?
    var numero = 0
    
    var myView: ReadyView {
        
        get {
            return self.view as! ReadyView
        }
    }
    
    override func viewDidLoad() {
        
        self.view = ReadyView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
            locationManager?.startUpdatingLocation()
            locationManager?.pausesLocationUpdatesAutomatically = false
            locationManager?.allowsBackgroundLocationUpdates = true
        }
    }
    
    //MARK: LOCATION MANAGER
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let lat = locations[locations.count - 1].coordinate.latitude
        let lon = locations[locations.count - 1].coordinate.longitude
        
        var info = ""
        
        if(UIApplication.sharedApplication().applicationState == UIApplicationState.Active) {
            
            info = "Running in foreground mode."
            
        } else {
            
            info = "Running in background mode."
        }
        
        let data = ["latitude": lat, "longitude": lon, "obs": info, "userId": "id"]
        
        Alamofire.request(.POST, "http://2bdf1396.ngrok.com", parameters: data as? [String : AnyObject], encoding: .JSON).responseJSON { response in
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
            
            //Get session ID and token
            //See if is connected to this session ID
                //If not, connect
                //If yes, just proceed
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

