//
//  ContactsDAO.swift
//  Hackpuc-New
//
//  Created by Victor Souza on 12/12/15.
//  Copyright © 2015 Grupo13. All rights reserved.
//

import Foundation
import RealmSwift

class ContactsDAO {
    
    var realm = try! Realm()
    
    func saveContacts(contacts: FPContact) {
        
        try! realm.write({
            
            self.realm.add(contacts)
        })
    }
}
