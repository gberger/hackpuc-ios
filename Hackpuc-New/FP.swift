//
//  FP.swift
//  Hackpuc-New
//
//  Created by Tauan Flores on 12/12/15.
//  Copyright © 2015 Grupo13. All rights reserved.
//

import Foundation
import UIKit

class FP: NSObject {
    
    class func mW() -> CGFloat {
        
        return UIScreen.mainScreen().bounds.width
        
    }
    
    class func mH() -> CGFloat {
        
        return UIScreen.mainScreen().bounds.height
        
    }
    
    class func wP() -> CGFloat {
        
        return UIScreen.mainScreen().bounds.width/414.0
        
    }
    
    class func hP() -> CGFloat {
        
        return UIScreen.mainScreen().bounds.height/736.0
        
    }
    
    class func cRa() -> CGFloat {
        
        return 0.0//CGFloat(Int(2 * wProp()))
        
}
}