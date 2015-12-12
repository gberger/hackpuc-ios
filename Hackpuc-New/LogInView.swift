//
//  ModelView.swift
//  Hackpuc-New
//
//  Created by Tauan Flores on 12/12/15.
//  Copyright © 2015 Grupo13. All rights reserved.
//

import Foundation

class LogInView: UIView {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        //Background
        
        let bgView = UIImageView(frame: CGRectMake(0, 0, 0, 0))
        bgView.image = UIImage(contentsOfFile: "Background.png")
        
        
        
    }
}
