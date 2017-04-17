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
        setupLayout()
        setupFeed()
    }
    
    func setupLayout() {
        textFeed.textColor = Style.firstColor
        textFeed.font = Style.fontTextInfoFeed
        
        titleFeed.textColor = Style.secondColor
        titleFeed.font = Style.fontTitleInfoFeed
        
        titleFeed.text = selectedItem.title
        textFeed.text = selectedItem.text
    }
    
    func setupFeed() {
        controller.setupFeedCell(feed: selectedItem) { (image) in
            self.pictureFeed.image = image
        }
    }
    
}
