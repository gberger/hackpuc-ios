//
//  ReadyView.swift
//  Hackpuc-New
//
//  Created by Joao Nassar Galante Guedes on 12/12/15.
//  Copyright © 2015 Grupo13. All rights reserved.
//

import Foundation

class ReadyView: UIView {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        print("Drew View")
    }
}