//
//  ViewController.swift
//  Hackpuc
//
//  Created by Joao Nassar Galante Guedes on 11/12/15.
//  Copyright © 2015 Grupo13. All rights reserved.
//

import UIKit
import Contacts

class ContactsPresenter: UIViewController {
    
    var myView: ModelView {
        
        get {
            return self.view as! ModelView
        }
    }
    
    override func viewDidLoad() {
        
        self.view = ModelView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), {
            
            let contacts = self.findContacts()
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                print(contacts[0].givenName)
                
                if let numero = contacts[0].phoneNumbers[0].value as? CNPhoneNumber {
                    print(numero.stringValue)
                }
            })
        })
        
    }
    
    func findContacts() -> [CNContact] {
        
        let store = CNContactStore()
        
        let keysToFetch = [CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName),
            CNContactImageDataKey,
            CNContactPhoneNumbersKey]
        
        let fetchRequest = CNContactFetchRequest(keysToFetch: keysToFetch)
        
        var contacts = [CNContact]()
        
        do {
            try store.enumerateContactsWithFetchRequest(fetchRequest, usingBlock: { (let contact, let stop) -> Void in
                contacts.append(contact)
            })
        }
        catch let error as NSError {
            print(error.localizedDescription)
        } 
        
        return contacts
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

