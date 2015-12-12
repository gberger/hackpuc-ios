//
//  FPContact.swift
//  Hackpuc-New
//
//  Created by Victor Souza on 12/12/15.
//  Copyright © 2015 Grupo13. All rights reserved.
//

import Foundation
import RealmSwift

class FPContact: Object {
    
    dynamic var id = 0
    dynamic var name = ""
    dynamic var phone = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}