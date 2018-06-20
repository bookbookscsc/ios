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
    let bookDataStore = BookDataStore.shared
    weak var viewController : UIViewController?
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard let bookType = BookType(rawValue: collectionView.tag) else {
            return 0
        }
        return bookDataStore.count(bookType)
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BookCollectionViewCell.identifier,
            for: indexPath
            ) as? BookCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let bookType = BookType(rawValue: collectionView.tag) else {
            return UICollectionViewCell()
        }
        let book = bookDataStore.book(type: bookType, idx: indexPath.row)
        cell.imageURL = book?.coverLink
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard let bookType = BookType(rawValue: collectionView.tag) else {
            return
        }
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let bookDetailVC = storyBoard.instantiateViewController(
            withIdentifier: "BookDetailViewController"
            ) as? BookDetailViewController else {
            return
        }
        let idx = indexPath.item
        bookDetailVC.bookInfo = (bookType, idx)
        viewController?.navigationController?.pushViewController(bookDetailVC,
                                                                 animated: true)
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
        return 30
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as? UITableViewHeaderFooterView)?.contentView.backgroundColor = .white
    }
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        (view as? UITableViewHeaderFooterView)?.contentView.backgroundColor = .white
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let bookType = BookType(rawValue: section) else {
            return nil
        }
        return bookType.title
    }
}
