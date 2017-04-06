//
//  NFBaseController.swift
//  newsfeed
//
//  Created by Daniel Martin Jimenez on 5/4/17.
//  Copyright © 2017 Daniel Martin Jimenez. All rights reserved.
//

import UIKit
import APESuperHUD

//MARK: - NFBaseControllerProtocol
protocol NFBaseControllerProtocol {
    
    func showLoadingIndicator()
    
    func hideLoadingIndicator()
    
    func createAlertWithCustomMessage(title: String, message: String, actionButtonTitle: String, preferredStyle: UIAlertControllerStyle)
}

//MARK: - NFBaseController
class NFBaseController {
    
    var alertError = UIAlertController()
    
    func showLoadingIndicator() {
        APESuperHUD.showOrUpdateHUD(loadingIndicator: .standard, message: "Loading", presentingView: (UIApplication.shared.keyWindow?.visibleViewController?.view)!)
    }
    
    func hideLoadingIndicator() {
        APESuperHUD.removeHUD(animated: false, presentingView: (UIApplication.shared.keyWindow?.visibleViewController?.view)!, completion: nil)
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
