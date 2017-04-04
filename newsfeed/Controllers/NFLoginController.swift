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
    
    func createAlertWithCustomMessage(title: String, message: String, actionButtonTitle: String, preferredStyle: UIAlertControllerStyle)
}

//MARK: - NFLoginController
class NFLoginController {
    
    static var instance : NFLoginController!
    let loginToList = "LoginToList"
    var alertError = UIAlertController()
    
    class func sharedInstance() -> NFLoginController {
        if instance == nil {
            instance = NFLoginController()
        }
        return instance
    }
    
    func signUp(emailUser: String, passUser: String) {
        FIRAuth.auth()!.createUser(withEmail: emailUser, password: passUser) { user, error in
            if error == nil {
                self.createAlertWithCustomMessage(title: "Success", message: "Your registration has been successful", actionButtonTitle: "OK", preferredStyle: .alert)
            } else {
                self.createAlertWithCustomMessage(title: "Error", message: (error?.localizedDescription)!, actionButtonTitle: "OK", preferredStyle: .alert)
            }
        }
    }
    
    func signIn(emailUser: String, passUser: String) {
        FIRAuth.auth()!.signIn(withEmail: emailUser, password: passUser) { entity, error in
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
    
    func createAlertWithCustomMessage(title: String, message: String, actionButtonTitle: String, preferredStyle: UIAlertControllerStyle) {
        self.alertError = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        let defaultAction = UIAlertAction(title: actionButtonTitle, style: .default, handler: nil)
        
        self.alertError.addAction(defaultAction)
        UIApplication.shared.keyWindow?.visibleViewController?.present(self.alertError, animated: true, completion: nil)
    }
}

//MARK: - UIWindow extension
public extension UIWindow {
    
    public var visibleViewController : UIViewController? {
        return UIWindow.getVisibleViewControllerFrom(self.rootViewController)
    }
    
    public static func getVisibleViewControllerFrom(_ vc: UIViewController?) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return UIWindow.getVisibleViewControllerFrom(nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return UIWindow.getVisibleViewControllerFrom(tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(pvc)
            } else {
                return vc
            }
        }
    }
}
