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
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let currentCell = sender as? FeedViewCell,
            let vc = segue.destination as? NFInfoFeedViewController,
            let currentCellIndex = collectionView.indexPath(for: currentCell) {
            vc.selectedItem = items[currentCellIndex.count]
        }
    }

    override func viewDidLoad() {
        getFeeds()
        setupLayout()
        setupNavigation()
    }
    
    func getFeeds() {
        controller.getFeeds { (feeds, error) in
            self.items = feeds
            self.collectionView.reloadData()
        }
    }
    
    func setupNavigation() {
        navigationController?.navigationBar.barTintColor = Style.secondColor
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: Style.fontNavBar!]        
        title = "NEWsFEED"
    }    
    
    func setupLayout() {
        view.layoutIfNeeded()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.automaticallyAdjustsScrollViewInsets = false;
    }
}

extension NFFeedListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "feed", for: indexPath) as? FeedViewCell)!
        
        cell.feed = self.items[indexPath.item]
        return cell
    }
}
