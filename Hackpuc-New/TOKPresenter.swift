//
//  ViewController.swift
//  Hackpuc
//
//  Created by Joao Nassar Galante Guedes on 11/12/15.
//  Copyright © 2015 Grupo13. All rights reserved.
//

import UIKit

class TOKPresenter: UIViewController, OTPublisherDelegate, OTSessionDelegate {
    
    var session: OTSession?
    
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
        session = OTSession(apiKey: "teste", sessionId: "randomValue", delegate: self)
        session?.connectWithToken("teste", error: nil)
    }
    
    //STREAM
    
    func publisher(publisher: OTPublisher!, didChangeCameraPosition position: AVCaptureDevicePosition) {
        
    }
    
    func publisher(publisher: OTPublisherKit!, didFailWithError error: OTError!) {
    
    }
    
    func publisher(publisher: OTPublisherKit!, streamCreated stream: OTStream!) {
        
    }
    
    func publisher(publisher: OTPublisherKit!, streamDestroyed stream: OTStream!) {
        
    }
    
    //SESSION
    
    func sessionDidConnect(session: OTSession!) {
        
        let publisher = OTPublisher(delegate: self, name: "AudioStream", audioTrack: true, videoTrack: false)
        session.publish(publisher, error: nil)
    }
    
    func sessionDidDisconnect(session: OTSession!) {
        
    }
    
    func session(session: OTSession!, didFailWithError error: OTError!) {
        
    }
    
    func session(session: OTSession!, streamCreated stream: OTStream!) {
        
    }
    
    func session(session: OTSession!, streamDestroyed stream: OTStream!) {
        
    }
    
    //MEMORY WARNING
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

