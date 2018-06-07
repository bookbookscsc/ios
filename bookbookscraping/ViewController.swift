//
//  ViewController.swift
//  bookbookscraping
//
//  Created by 오민호 on 2018. 5. 17..
//  Copyright © 2018년 오민호. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var trendingCollectionView : UICollectionView!
    @IBOutlet var newReleaseCollectionView : UICollectionView!
    @IBOutlet var bestSellerCollectionView : UICollectionView!
    @IBOutlet var bookDataProvider : (UICollectionViewDelegate & UICollectionViewDataSource)!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
