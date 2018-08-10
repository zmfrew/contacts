//
//  ContactDetailViewController.swift
//  Contacts
//
//  Created by Zachary Frew on 8/10/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    
    // MARK: - Instance Properties
    var contact: Contact?
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addVerticalGradientLayer(topColor: .primaryColor, bottomColor: .secondaryColor)
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let name = nameTF.text, !name.isEmpty, name != " " else {
            presentErrorAlert()
            return
        }
        
//        let phoneNumber = phoneNumberTF.text ?? nil
//        let email = emailTF.text ?? nil
        
        if let contact = contact {
            ContactController.shared.update(contact: contact, withName: name, phoneNumber: phoneNumberTF.text, email: emailTF.text) { (success) in
                if success {
                    self.popNavigationViewController()
                }
            }
        } else {
            ContactController.shared.createNewContact(withName: name, phoneNumber: phoneNumberTF.text, email: emailTF.text) { (success) in
                if success {
                    self.popNavigationViewController()
                }
            }
        }
    }
    
    // MARK: - Instance Methods
    func updateViews() {
        guard let contact = contact else { return }
        
        nameTF.text = contact.name
        phoneNumberTF.text = contact.phoneNumber
        emailTF.text = contact.email
    }
    
    func popNavigationViewController() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func presentErrorAlert() {
        let alert = UIAlertController(title: "Please make sure the Name field is completed.", message: nil, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alert.addAction(dismissAction)
        present(alert, animated: true, completion: nil)
    }
    
}
