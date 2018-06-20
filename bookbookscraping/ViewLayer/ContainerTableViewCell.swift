//
//  CardCollectionViewCell.swift
//  bookbookscraping
//
//  Created by 오민호 on 2018. 6. 7..
//  Copyright © 2018년 오민호. All rights reserved.
//

import UIKit
import Kingfisher

class ContainerTableViewCell : UITableViewCell {
    static let identifier = "ContainerTableViewCell"
    @IBOutlet var collectionView : UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.collectionViewLayout = {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.minimumLineSpacing = 20
            flowLayout.itemSize = CGSize(width: 80, height: 140)
            flowLayout.scrollDirection = .horizontal
            return flowLayout
        }()
    }
}
