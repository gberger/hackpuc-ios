//
//  ViewController.swift
//  Hackpuc
//
//  Created by Joao Nassar Galante Guedes on 11/12/15.
//  Copyright © 2015 Grupo13. All rights reserved.
//

import UIKit
import CoreLocation
import Contacts
import AVFoundation

class SetupPresenter: UIViewController, SetupViewProtocol, CLLocationManagerDelegate {
    
    var step = 0
    
    var locationManager: CLLocationManager?
    var cnmanager: CNContactStore?
    
    var myView: SetupView {
        
        get {
            return self.view as! SetupView
        }
    }
    
    override func viewDidLoad() {
        
        self.view = SetupView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
        self.myView.delegate = self
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didPressNext() {
        
        if(step == 0) {
            
            askGPSPermission()
            
        } else if(step == 1) {
            
            askContactPermission()
            
        } else if(step == 2) {
            
            askMicrophonePermission()
            
        } else if(step == 3) {
            
        }
        
    }
    
    func nextStep() {
        
        step++
        
        if(step == 1) {
            
            self.myView.label?.text = "Seus contatos do celular também serão utilizados para receberem mensagens SMS em caso de emergência.\n\nPor favor, habilite o acesso aos seus contatos."
            
        } else if(step == 2) {
            
            self.myView.label?.text = "Você pode fazer uma transmissão ao vivo do áudio do seu celular durante uma situação de emergência. Selecione esta opção agora.\n\n(Você pode modificar isto novamente no painel de controle do seu celular)."
            
        } else if(step == 3) {
            
            self.myView.label?.text = "Final"
        }
    }
    
    func askGPSPermission() {
        
        let authorized = CLLocationManager.authorizationStatus()
        
        if(authorized != CLAuthorizationStatus.AuthorizedAlways) {
            
            locationManager = CLLocationManager()
            locationManager?.requestAlwaysAuthorization()
            
        } else {
            
            nextStep()
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if(status == CLAuthorizationStatus.AuthorizedAlways) {
            
            self.nextStep()
        }
        
    }
    
    func askContactPermission() {
        
        let authorized = CNContactStore.authorizationStatusForEntityType(CNEntityType.Contacts)
        
        if(authorized != CNAuthorizationStatus.Authorized) {
            
            cnmanager = CNContactStore()
            cnmanager?.requestAccessForEntityType(CNEntityType.Contacts, completionHandler: { (vl, error) -> Void in
                
                if(vl == true) {
                    
                    self.nextStep()
                }
                
            })
            
        } else {
            
            nextStep()
        }
    }
    
    func askMicrophonePermission() {
        
        let authorized = AVAudioSession.sharedInstance().recordPermission()
        
        if(authorized != AVAudioSessionRecordPermission.Granted) {
            
            AVAudioSession.sharedInstance().requestRecordPermission { (value) -> Void in
                
                if(value == true) {
                    
                    self.nextStep()
                }
            }
        
        } else {
            
            nextStep()
        }
    }
}

