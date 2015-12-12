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
    
    var myView: UIView {
        get {
            return self.view as UIView
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        let authorized = CLLocationManager.authorizationStatus()
        
        if(authorized == CLAuthorizationStatus.Restricted || authorized == CLAuthorizationStatus.Denied) {
            
            //Denied to use the position test commit
            
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
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let lat = locations[locations.count - 1].coordinate.latitude
        let lon = locations[locations.count - 1].coordinate.longitude
        
        var data: [String: AnyObject]!
        
        if(UIApplication.sharedApplication().applicationState == UIApplicationState.Active) {
            
            data = ["latitude": lat, "longitude": lon, "text": "Foreground Running"]
            numero++
            
        } else {
            
            data = ["latitude": lat, "longitude": lon, "text": "Background Running"]
            numero++
            
        }
        
        print(data)
        Alamofire.request(.POST, "http://2bdf1396.ngrok.com", parameters: data, encoding: .JSON)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
        print(error)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

