//
//  ContactsListTableViewController.swift
//  Contacts
//
//  Created by Zachary Frew on 8/10/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import UIKit

class ContactsListTableViewController: UITableViewController {
    
    // MARK: - LifeCycleMethods
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveEntries()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    // MARK: - Instance Methods
    func retrieveEntries() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        ContactController.shared.retrieveAllContacts { (success) in
            if success {
                self.updateViews()
            }
        }
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    func updateViews() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - TableViewDataSource
    // TODO: - Create a new section for each alphabet letter in contact list
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        return 0
    //    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContactController.shared.contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        let contact = ContactController.shared.contacts[indexPath.row]
        cell.textLabel?.text = contact.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let contact = ContactController.shared.contacts[indexPath.row]
            ContactController.shared.delete(contact: contact) { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                }
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailFromCell" {
            guard let detailVC = segue.destination as? ContactDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let contact = ContactController.shared.contacts[indexPath.row]
            detailVC.contact = contact
        }
    }
    
}
