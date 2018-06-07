//
//  CardCollectionViewCell.swift
//  bookbookscraping
//
//  Created by 오민호 on 2018. 6. 7..
//  Copyright © 2018년 오민호. All rights reserved.
//

import UIKit
import Kingfisher

class BookCollectionViewCell: UICollectionViewCell {
    var imageURL : URL? {
        didSet {
            guard let imageURL = self.imageURL else {return}
            thumbImageView.kf.setImage(with: ImageResource(downloadURL: imageURL))
        }
    }
    var thumbImageView : UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.thumbImageView = UIImageView()
        self.contentView.backgroundColor = UIColor(hexString: "#F8F7FC")
        self.layer.cornerRadius = 1
        self.clipsToBounds = true
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.thumbImageView.image = nil
    }
}
