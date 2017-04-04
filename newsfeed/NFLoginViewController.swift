//
//  NFLoginViewController.swift
//  newsfeed
//
//  Created by Daniel Martin Jimenez on 4/4/17.
//  Copyright © 2017 Daniel Martin Jimenez. All rights reserved.
//

import UIKit
import FirebaseAuth

class NFLoginViewController: UIViewController  {
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var textFieldLoginEmail: UITextField!
    @IBOutlet var textFieldLoginPassword: UITextField!
    
    var controller = NFLoginController.sharedInstance()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLayout()
    }
    
    func setupLayout() {
        backgroundView.backgroundColor = Style.primaryColor
        titleLabel.font = Style.fontTitleLogin
        
        textFieldLoginEmail.placeholder = "Email"
        textFieldLoginEmail.font = Style.fontPlaceholderLogin
        
        textFieldLoginPassword.placeholder = "Password"
        textFieldLoginPassword.font = Style.fontPlaceholderLogin
    }
    
    // MARK: Actions
    @IBAction func loginDidTouch(sender: AnyObject) {
        controller.signIn(emailUser: textFieldLoginEmail.text!, passUser: textFieldLoginPassword.text!)
    }
    
    @IBAction func signUpDidTouch(sender: AnyObject) {
        controller.signUp(emailUser: textFieldLoginEmail.text!, passUser: textFieldLoginPassword.text!)
    }
}

extension NFLoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldLoginEmail {
            textFieldLoginPassword.becomeFirstResponder()
        }
        if textField == textFieldLoginPassword {
            textField.resignFirstResponder()
        }
        return true
    }
}
