//
//  NFFeedListViewController.swift
//  newsfeed
//
//  Created by Daniel Martin Jimenez on 5/4/17.
//  Copyright © 2017 Daniel Martin Jimenez. All rights reserved.
//

import UIKit

class NFFeedListViewController: UIViewController {
    
    var controller = NFFeedListController.sharedInstance()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getFeeds()
        setupLayout()
    }
    
    func getFeeds() {
        controller.getFeeds()
    }
    
    
    func setupLayout() {
        
    }
}
