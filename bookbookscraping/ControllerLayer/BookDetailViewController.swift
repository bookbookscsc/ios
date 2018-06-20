//
//  BookDetailViewController.swift
//  bookbookscraping
//
//  Created by 오민호 on 2018. 6. 15..
//  Copyright © 2018년 오민호. All rights reserved.
//

import UIKit
import Kingfisher

class BookDetailViewController : UIViewController {
    var bookInfo : (bookType: BookType, idx: Int)?
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var authorLabel : UILabel!
    @IBOutlet weak var publisherLabel : UILabel!
    @IBOutlet weak var coverImageView : UIImageView!
    @IBOutlet weak var reviewMetaCollectionView : UICollectionView!
    @IBOutlet weak var reviewTableView : UITableView!
    @IBOutlet weak var reviewDataProvider : ReviewDataProvider!
    let reviewDataStore = ReviewDataStore()
    let responseDecoder : JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
        return jsonDecoder
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let bookInfo = self.bookInfo else { return }
        guard let book = BookDataStore.shared.book(type: bookInfo.bookType,
                                                 idx: bookInfo.idx) else {
                                                    return
        }
        requestReviews(of: book)
        titleLabel.text = book.title
        authorLabel.text = book.author
        publisherLabel.text = book.publisher
        if let coverLink = book.coverLink {
            let imageResource = ImageResource(downloadURL: coverLink)
            coverImageView.kf.setImage(with: imageResource)
        }
    }
    private func requestReviews(of book : Book) {
        NetworkAdaptor.request(target: RestAPI.reviews(of: book.isbn13),
                               successHandler: { (response) in
                                guard let reviewAPIResponse = try? response.map(ReviewListResponse.self,
                                                                                using: self.responseDecoder) else {
                                                                                    return
                                }
                                self.reviewDataStore.update(reviewAPIResponse.item, of : book.isbn13)
                                self.reviewDataStore.update(reviewAPIResponse.reviewMeta, of: book.isbn13)
                                DispatchQueue.main.async {
                                    self.reviewMetaCollectionView.reloadData()
                                    self.reviewTableView.reloadData()
                                }
        }, errorHandler: { (serverError) in
            print(serverError)
        }, failureHandler: { (moyaError) in
            print(moyaError)
        })
    }
}
