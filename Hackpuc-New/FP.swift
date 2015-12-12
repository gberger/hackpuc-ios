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
    
    class func round(number: CGFloat) -> CGFloat {
        
        return CGFloat(Int(number))
        
    }
    

    
    //Font's
    
    class func fontName() -> String {
        
        return "GeosansLight-Regular"
        
    }
    
    //Font's Sizes
    
    class func normalFS() -> CGFloat {
            
            return CGFloat(Int(26 * wP()))
            
        }
    
    
    class func smallFS() -> CGFloat {
        
        return CGFloat(Int(29 * wP()))
        
    }
    
    class func titFS() -> CGFloat {
        
        return CGFloat(Int(34 * wP()))
        
    }
        
}
