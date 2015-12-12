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
    
    class func mainWidth() -> CGFloat {
        
        return UIScreen.mainScreen().bounds.width
        
    }
    
    class func mainHeight() -> CGFloat {
        
        return UIScreen.mainScreen().bounds.height
        
    }
    
    class func wProp() -> CGFloat {
        
        return UIScreen.mainScreen().bounds.width/414.0
        
    }
    
    class func hProp() -> CGFloat {
        
        return UIScreen.mainScreen().bounds.height/736.0
        
    }
    
    class func cornerRadius() -> CGFloat {
        
        return 0.0//CGFloat(Int(2 * wProp()))
        
}
}