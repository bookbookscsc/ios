//
//  BookDataProvider.swift
//  bookbookscraping
//
//  Created by 오민호 on 2018. 6. 7..
//  Copyright © 2018년 오민호. All rights reserved.
//

import UIKit

// MARK: CollectionView Data Provider
class BookDataProvider : NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    let bookManager = BookManager.shared
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BookCollectionViewCell.identifier,
            for: indexPath
            ) as? BookCollectionViewCell else {
            return UICollectionViewCell()
        }
        print(collectionView.tag)
        guard let bookType = BookType(rawValue: collectionView.tag) else {
            return UICollectionViewCell()
        }
        let book = bookManager.book(type: bookType, idx: indexPath.row)
        cell.imageURL = book?.coverLink
        return cell
    }
}

// MARK: TableView Data Provider
extension BookDataProvider: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ContainerTableViewCell.identifier,
            for: indexPath
            ) as? ContainerTableViewCell else {
            return UITableViewCell()
        }
        cell.collectionView.tag = indexPath.section
        cell.collectionView.reloadData()
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}
