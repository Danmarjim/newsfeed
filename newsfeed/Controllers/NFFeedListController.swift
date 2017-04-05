//
//  NFFeedListController.swift
//  newsfeed
//
//  Created by Daniel Martin Jimenez on 5/4/17.
//  Copyright © 2017 Daniel Martin Jimenez. All rights reserved.
//

import UIKit
import FirebaseDatabase

protocol NFFeedControllerProtocol {
    
    func getFeeds()
}

class NFFeedListController: NFBaseController {
    
    static var instance : NFFeedListController!
    let rootRef = FIRDatabase.database().reference(fromURL: "https://newsfeed-fd60a.firebaseio.com/")
    
    class func sharedInstance() -> NFFeedListController {
        if instance == nil {
            instance = NFFeedListController()
        }
        return instance
    }
    
    func getFeeds() {
        super.showLoadingIndicator()
        self.rootRef.observe(FIRDataEventType.value, with: { (FIRDataSnapshot) in
            super.hideLoadingIndicator()
            _ = FIRDataSnapshot.value as! [String : AnyObject]
        })
    }
}
