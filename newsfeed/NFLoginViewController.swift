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
    @IBOutlet var scrollView: UIScrollView!
    
    var controller = NFLoginController.sharedInstance()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.textFieldLoginEmail.delegate = self
        self.textFieldLoginPassword.delegate = self
        setupLayout()
    }
    
    // MARK: Layouts
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

//MARK: TextField Delegate
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

//MARK: Keyboard Actions
extension NFLoginViewController {
    
    func keyboardWillShow(notification:NSNotification) {
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        self.scrollView.contentInset = contentInset
    }
    
    func keyboardWillHide(notification:NSNotification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        self.scrollView.contentInset = contentInset
    }
}
