//
//  MarkCollectionViewCell.swift
//  bookbookscraping
//
//  Created by 오민호 on 2018. 6. 18..
//  Copyright © 2018년 오민호. All rights reserved.
//

import UIKit
import Kingfisher

class ReviewMetaCollectionViewCell: UICollectionViewCell {
    static let identifier = "ReviewMetaCollectionViewCell"
    var reviewMeta : ReviewMeta? {
        didSet {
            guard let reviewMeta = self.reviewMeta else { return }
            if let logoURL = reviewMeta.bookstore.logoURL {
                let resource = ImageResource(downloadURL: logoURL)
                bookStoreLogoImageView.kf.setImage(with: resource)
            }
            bookStoreLabel.text = reviewMeta.bookstore.name
            ratingLabel.text = "\(reviewMeta.rating)"
            countLabel.text = "\(reviewMeta.count)"
        }
    }
    @IBOutlet weak var bookStoreLogoImageView: UIImageView!
    @IBOutlet weak var bookStoreLabel : UILabel!
    @IBOutlet weak var ratingLabel : UILabel!
    @IBOutlet weak var countLabel: UILabel!
}
