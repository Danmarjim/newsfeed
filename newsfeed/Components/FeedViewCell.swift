//
//  FeedViewCell.swift
//  newsfeed
//
//  Created by Daniel Martin Jimenez on 10/4/17.
//  Copyright © 2017 Daniel Martin Jimenez. All rights reserved.
//

import UIKit

class FeedViewCell: UICollectionViewCell {
    
    @IBOutlet var titleFeed: UILabel!
    @IBOutlet var pictureFeed: UIImageView!
    @IBOutlet var backgroundTitle: UIView!
    
    var controller = NFFeedListController.sharedInstance()

    var feed: NFFeed? {
        didSet {
            guard let feed = feed else { return }
            
            controller.setupFeedCell(feed: feed) { (image) in
                self.pictureFeed.image = image
                self.titleFeed.text = feed.title
                
                //Setup layout
                self.titleFeed.textColor = UIColor.black
                self.pictureFeed.layer.cornerRadius = 5
                self.pictureFeed.clipsToBounds = true
                self.backgroundTitle.backgroundColor = Style.thirdColorWithAlpha
                self.backgroundTitle.layer.cornerRadius = 15
            }
        }
    }
}
