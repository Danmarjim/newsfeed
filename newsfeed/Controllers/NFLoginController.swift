//
//  NFLoginController.swift
//  newsfeed
//
//  Created by Daniel Martin Jimenez on 4/4/17.
//  Copyright © 2017 Daniel Martin Jimenez. All rights reserved.
//

import UIKit
import FirebaseAuth

//MARK: - NFLoginControllerProtocol
protocol NFLoginControllerProtocol {
    
    func signUp(emailUser: String, passUser: String)
    
    func signIn(emailUser: String, passUser: String)
    
    func nextAfterLogin(performSegueWithIdentifier: String)
}

//MARK: - NFLoginController
class NFLoginController : NFBaseController{
    
    static var instance : NFLoginController!
    let loginToList = "LoginToList"
    
    class func sharedInstance() -> NFLoginController {
        if instance == nil {
            instance = NFLoginController()
        }
        return instance
    }
    
    func signUp(emailUser: String, passUser: String) {
        super.showLoadingIndicator()
        FIRAuth.auth()!.createUser(withEmail: emailUser, password: passUser) { snapshot, error in
            super.hideLoadingIndicator()
            if error == nil {
                self.signIn(emailUser: emailUser, passUser: passUser)
            } else {
                self.createAlertWithCustomMessage(title: "Error", message: (error?.localizedDescription)!, actionButtonTitle: "OK", preferredStyle: .alert)
            }
        }
    }
    
    func signIn(emailUser: String, passUser: String) {
        super.showLoadingIndicator()
        FIRAuth.auth()!.signIn(withEmail: emailUser, password: passUser) { snapshot, error in
            super.hideLoadingIndicator()
            if(error == nil) {
                self.nextAfterLogin(identifier: self.loginToList)
            } else {
                self.createAlertWithCustomMessage(title: "Error", message: (error?.localizedDescription)!, actionButtonTitle: "OK", preferredStyle: .alert)
            }
        }
    }
    
    func nextAfterLogin(identifier: String) {
        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            if user != nil {
                UIApplication.shared.keyWindow?.visibleViewController?.performSegue(withIdentifier: identifier, sender: nil)
            }
        }
    }
}
