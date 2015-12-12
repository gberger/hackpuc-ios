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
    
    func publisher(publisher: OTPublisherKit!, didFailWithError error: OTError!) {
        
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
     
        print(error)
    }
    
    func session(session: OTSession!, streamCreated stream: OTStream!) {
        
        print("Stream Created")
    }
    
    func session(session: OTSession!, streamDestroyed stream: OTStream!) {
        
        print("Stream Destroyed")
    }
    
    //MEMORY WARNING
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

