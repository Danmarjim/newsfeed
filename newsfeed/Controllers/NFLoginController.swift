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
    
    func signUp(_ emailUser: String, passUser: String)
    
    func signIn(_ emailUser: String, passUser: String)
    
    func nextAfterLogin(performSegueWithIdentifier: String)
}

//MARK: - NFLoginController
class NFLoginController {
    
    static var instance : NFLoginController!
    let loginToList = "LoginToList"
    
    class func sharedInstance() -> NFLoginController {
        if instance == nil {
            instance = NFLoginController()
        }
        return instance
    }
    
    func signUp(_ emailUser: String, passUser: String) {
        FIRAuth.auth()!.createUser(withEmail: emailUser, password: passUser) { user, error in
            if error == nil {
                //Show alert with message "SIGNUP SUCCESS"
            } else {
                //Show alert with error message
            }
        }
    }
    
    func signIn(_ emailUser: String, passUser: String) {
        FIRAuth.auth()!.signIn(withEmail: emailUser, password: passUser) { entity, error in
            if(error == nil) {
                self.nextAfterLogin(identifier: self.loginToList)
            } else {
                //Show alert with error message
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
