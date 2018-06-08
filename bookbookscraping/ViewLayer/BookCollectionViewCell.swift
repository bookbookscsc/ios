//
//  BookCollectionViewCell.swift
//  bookbookscraping
//
//  Created by 오민호 on 2018. 6. 8..
//  Copyright © 2018년 오민호. All rights reserved.
//

import UIKit
import Kingfisher

class BookCollectionViewCell: UICollectionViewCell {
    static let identifier = "BookCollectionViewCell"
    var imageURL : URL? {
        didSet {
            guard let imageURL = self.imageURL else {return}
            thumbImageView.kf.setImage(with: ImageResource(downloadURL: imageURL))
        }
    }
    @IBOutlet var thumbImageView : UIImageView!
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
