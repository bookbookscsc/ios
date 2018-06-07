//
//  BookDataProvider.swift
//  bookbookscraping
//
//  Created by 오민호 on 2018. 6. 7..
//  Copyright © 2018년 오민호. All rights reserved.
//

import UIKit

class BookDataProvider : NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
