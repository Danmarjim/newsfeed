//
//  FeedViewCell.swift
//  newsfeed
//
//  Created by Daniel Martin Jimenez on 10/4/17.
//  Copyright © 2017 Daniel Martin Jimenez. All rights reserved.
//

import UIKit
import Hero

class FeedViewCell: UICollectionViewCell {
    
    @IBOutlet var titleFeed: UILabel!
    @IBOutlet var pictureFeed: UIImageView!
    @IBOutlet var backgroundTitle: UIView!
    
    var controller = NFFeedListController.sharedInstance()

    var feed: NFFeed? {
        didSet {
            guard let feed = feed else { return }
            let title = feed.title
            
            controller.setupFeedCell(feed: feed) { (image) in
                self.pictureFeed.image = image
                self.titleFeed.text = feed.title
            }
            
            heroID = "\(title)"
            
            //Setup layout
            titleFeed.textColor = UIColor.white
            titleFeed.font = Style.fontFeedList
            
            pictureFeed.layer.cornerRadius = 5
            pictureFeed.clipsToBounds = true
            
            backgroundTitle.backgroundColor = Style.thirdColor.withAlphaComponent(0.6)
            backgroundTitle.layer.cornerRadius = 15
        }
    }
}
