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
    var items: [NFFeed] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getFeeds()
        setupLayout()
        setupNavigation()
    }
    
    func getFeeds() {
        items = controller.getFeeds()
    }
    
    func setupNavigation() {
        navigationController?.navigationBar.barTintColor = Style.secondColor
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: Style.fontTextNavBar!]        
        title = "News"
    }    
    
    func setupLayout() {
        
    }
}
