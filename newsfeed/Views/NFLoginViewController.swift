//
//  NFLoginViewController.swift
//  newsfeed
//
//  Created by Daniel Martin Jimenez on 4/4/17.
//  Copyright © 2017 Daniel Martin Jimenez. All rights reserved.
//

import UIKit
import FirebaseAuth

class NFLoginViewController: NFBaseViewController  {
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var textFieldLoginEmail: UITextField!
    @IBOutlet var textFieldLoginPassword: UITextField!    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var buttonSignIn: UIButton!
    @IBOutlet var buttonSignUp: UIButton!
    
    var controller = NFLoginController.sharedInstance()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tap(gesture:)))
        self.view.addGestureRecognizer(tapGesture)
        
        self.textFieldLoginEmail.delegate = self
        self.textFieldLoginPassword.delegate = self
        setupLayout()
    }
    
    // MARK: Layouts
    func setupLayout() {
        titleLabel.font = Style.fontTitleLogin
        titleLabel.textColor = Style.secondColor
        
        textFieldLoginEmail.font = Style.fontPlaceholderLogin
        textFieldLoginEmail.layer.borderColor = Style.firstColor.cgColor
        textFieldLoginEmail.layer.borderWidth = 0.5
        textFieldLoginEmail.layer.cornerRadius = 8
        
        textFieldLoginPassword.font = Style.fontPlaceholderLogin
        textFieldLoginPassword.layer.borderColor = Style.firstColor.cgColor
        textFieldLoginPassword.layer.borderWidth = 0.5
        textFieldLoginPassword.layer.cornerRadius = 8
        
        buttonSignIn.backgroundColor = Style.secondColor
        buttonSignIn.layer.cornerRadius = 15
        buttonSignIn.titleLabel?.font = Style.fontPlaceholderLogin
        
        buttonSignUp.layer.cornerRadius = 15
        buttonSignUp.layer.borderWidth = 2
        buttonSignUp.layer.borderColor = Style.thirdColor.cgColor
        buttonSignIn.titleLabel?.font = Style.fontPlaceholderLogin
        buttonSignUp.setTitleColor(Style.thirdColor, for: .normal)
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
    
    func tap(gesture: UITapGestureRecognizer) {
        textFieldLoginEmail.resignFirstResponder()
        textFieldLoginPassword.resignFirstResponder()
    }
}
