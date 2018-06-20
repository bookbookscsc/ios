//
//  File.swift
//  bookbookscraping
//
//  Created by 오민호 on 2018. 6. 18..
//  Copyright © 2018년 오민호. All rights reserved.
//

import UIKit

class ReviewDataProvider: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    var reviewDataStore : ReviewDataStore?
    var book : Book?
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell (
            withReuseIdentifier: ReviewMetaCollectionViewCell.identifier,
            for: indexPath) as? ReviewMetaCollectionViewCell else {
                return UICollectionViewCell()
        }
        guard let book = self.book else {
            return UICollectionViewCell()
        }
        guard let reviewDataStore = self.reviewDataStore else {
            return UICollectionViewCell()
        }
        cell.reviewMeta = reviewDataStore.reviewMeta(of: book.isbn13,
                                                     idx: indexPath.item)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard let book = self.book else {return 0}
        return reviewDataStore?.count(.reviewMeta, of: book.isbn13) ?? 0
    }
}

extension ReviewDataProvider: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}
