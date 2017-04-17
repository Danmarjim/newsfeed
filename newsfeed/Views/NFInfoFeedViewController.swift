//
//  NFInfoFeedViewController.swift
//  newsfeed
//
//  Created by Daniel Martin Jimenez on 15/4/17.
//  Copyright © 2017 Daniel Martin Jimenez. All rights reserved.
//

import UIKit

class NFInfoFeedViewController: UIViewController {

    @IBOutlet var pictureFeed: UIImageView!
    @IBOutlet var titleFeed: UILabel!
    @IBOutlet var textFeed: UILabel!
    
    var selectedItem: NFFeed!
    var controller = NFFeedListController.sharedInstance()
    
    override func viewDidLoad() {
        setupFeed()
    }
    
    func setupFeed() {
        controller.setupFeedCell(feed: selectedItem) { (image) in
            self.pictureFeed.image = image
            self.titleFeed.text = self.selectedItem.title
            self.textFeed.text = self.selectedItem.text
            
            //Setup layout
            self.pictureFeed.layer.cornerRadius = 15
            self.textFeed.textColor = Style.firstColor
            self.titleFeed.textColor = Style.secondColor
        }
    }
    
}
