//
//  ContactController.swift
//  Contacts
//
//  Created by Zachary Frew on 8/10/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import Foundation
import CloudKit

class ContactController {
    
    // MARK: - Singleton
    static let shared = ContactController()
    
    // MARK: - Instance Properties
    let privateDB = CKContainer.default().privateCloudDatabase
    var contacts: [Contact] = []
    
    // MARK: - CRUD Methods
    func createNewContact(withName name: String, phoneNumber: String?, email: String?, completion: @escaping (Bool) -> Void) {
        let contact = Contact(name: name, phoneNumber: phoneNumber, email: email)
        let contactRecord = CKRecord(contact: contact)
        
        privateDB.save(contactRecord) { (record, error) in
            if let error = error {
                print("Error occurred saving contact: \(error.localizedDescription).")
                completion(false)
                return
            }
            
            self.contacts.append(contact)
            completion(true)
        }
    }
    
    func retrieveAllContacts(completion: @escaping (Bool) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: Contact.typeKey, predicate: predicate)
        
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error occurred saving contact: \(error.localizedDescription).")
                completion(false)
                return
            }
            
            guard let records = records else { completion(false) ; return }
            
            let contacts = records.compactMap { Contact(ckRecord: $0) }
            self.contacts = contacts
            completion(true)
        }
    }
    
    func update(contact: Contact, withName name: String, phoneNumber: String?, email: String?, completion: @escaping (Bool) -> Void) {
        contact.name = name
        contact.phoneNumber = phoneNumber
        contact.email = email
        
        let contactRecord = CKRecord(contact: contact)
        let operation = CKModifyRecordsOperation(recordsToSave: [contactRecord], recordIDsToDelete: nil)
        
        operation.savePolicy = .changedKeys
        operation.queuePriority = .high
        operation.qualityOfService = .userInteractive
        operation.completionBlock = {
            completion(true)
        }
        
        privateDB.add(operation)
    }
    
    func delete(contact: Contact, completion: @escaping (Bool) -> Void) {
        // TODO: - Add cloudKitRecordID to implement delete functionality.
    }
    
}
