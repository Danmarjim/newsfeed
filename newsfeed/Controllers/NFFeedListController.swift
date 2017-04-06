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
    
    var items: [NFFeed] = []
    
    class func sharedInstance() -> NFFeedListController {
        if instance == nil {
            instance = NFFeedListController()
        }
        return instance
    }
    
    func getFeeds() -> Array<NFFeed> {
        super.showLoadingIndicator()
        self.rootRef.observe(FIRDataEventType.value, with: { snapshot in
            super.hideLoadingIndicator()
            
            var newItems: [NFFeed] = []
            for item in snapshot.children {
                let feed = NFFeed(snapshot: item as! FIRDataSnapshot)
                newItems.append(feed)
            }
            self.items = newItems
        })
        return items
    }
}
