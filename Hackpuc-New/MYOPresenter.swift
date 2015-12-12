//
//  MYOPresenter.swift
//  Hackpuc
//
//  Created by Victor Souza on 12/12/15.
//  Copyright © 2015 Grupo13. All rights reserved.
//

import Foundation
import UIKit

class MYOPresenter: UIViewController {
    
    var myo: [TLMMyo] = []
    var presented: Bool = false
    var begin: Bool = false
    var waiting: Bool = false
    
    override func viewDidLoad() {
        
        //        presented = false
        
        let poseObserver = NSNotificationCenter.defaultCenter()
        poseObserver.addObserver(self, selector: Selector("didRecievePoseChange:"), name: TLMMyoDidReceivePoseChangedNotification, object: nil)
        //        let orientationObserver = NSNotificationCenter.defaultCenter()
        //        orientationObserver.addObserver(self, selector: Selector("didRecieveOrientationEvent:"), name: TLMMyoDidReceiveOrientationEventNotification, object: nil)
        let connectionObserver = NSNotificationCenter.defaultCenter()
        connectionObserver.addObserver(self, selector: Selector("connectionEvent:"), name: TLMHubDidConnectDeviceNotification, object: nil)
        //        let attachObserver = NSNotificationCenter.defaultCenter()
        //        attachObserver.addObserver(self, selector: Selector("attachEvent:"), name: TLMHubDidAttachDeviceNotification, object: nil)
        //        let detachObserver = NSNotificationCenter.defaultCenter()
        //        detachObserver.addObserver(self, selector: Selector("detachEvent:"), name: TLMHubDidDetachDeviceNotification, object: nil)
        //        let syncObserver = NSNotificationCenter.defaultCenter()
        //        syncObserver.addObserver(self, selector: Selector("syncEvent:"), name: TLMMyoDidReceiveArmSyncEventNotification, object: nil)
        //        let dataObserver = NSNotificationCenter.defaultCenter()
        //        dataObserver.addObserver(self, selector: Selector("dataEvent:"), name: TLMMyoDidReceiveEmgEventNotification,object: nil)
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if !presented{
            
            let navigationController = TLMSettingsViewController.settingsInNavigationController() as UINavigationController
            self.presentViewController(navigationController, animated: true, completion: nil)
            presented = true
        }
    }
    
    func didRecievePoseChange(notification: NSNotification){
        
        var dict:Dictionary<String,TLMPose> = notification.userInfo as! Dictionary<String,TLMPose>
        
        let pose = dict[kTLMKeyPose]
        switch pose!.type {
            
        case TLMPoseType.DoubleTap :
            print("double")
            
            //            self.poseLabel.text = "Double Tap"
            //            if pose?.myo!.isLocked == true{
            //                pose?.myo!.lock()
            //            }
            //
            //            else{
            //                pose?.myo!.unlockWithType(TLMUnlockType.Hold)
            //                pose?.myo!.vibrateWithLength(TLMVibrationLength.Short)
            //            }
            break;
            
        case TLMPoseType.FingersSpread:
            print("fingers")
            break;
            
        case TLMPoseType.Fist:
            print("fist")
            if !begin { self.emergency() ; begin = true }
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
    
    func connectionEvent(notification: NSNotification){
        
        myo = TLMHub.sharedHub().myoDevices() as! [TLMMyo]
        print("connected")
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
