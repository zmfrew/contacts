//
//  Contact.swift
//  Contact
//
//  Created by Zachary Frew on 8/10/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import Foundation
import CloudKit

class Contact {
    
    // MARK: - Constant Keys
    static let typeKey = "Contact"
    fileprivate static let nameKey = "name"
    fileprivate static let phoneNumberKey = "phoneNumber"
    fileprivate static let emailKey = "email"
    
    // MARK: - Instance Properties
    var name: String
    var phoneNumber: String?
    var email: String?
    
    // MARK: - CloudKit Properties
    
    
    // MARK: - Initializers
    init(name: String, phoneNumber: String?, email: String?) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
    }
    
    init?(ckRecord: CKRecord) {
        guard let name = ckRecord[Contact.nameKey] as? String,
            let phoneNumber = ckRecord[Contact.phoneNumberKey] as? String,
            let email = ckRecord[Contact.emailKey] as? String else { return nil }
        
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
    }
    
}

// MARK: - CKRecord Extension - Custom Initializer
extension CKRecord {
    
    convenience init(contact: Contact) {
        self.init(recordType: Contact.typeKey)
        self.setValue(contact.name, forKey: Contact.nameKey)
        self.setValue(contact.phoneNumber, forKey: Contact.phoneNumberKey)
        self.setValue(contact.email, forKey: Contact.emailKey)
    }
    
}
