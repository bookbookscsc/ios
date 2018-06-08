//
//  Extensions+Collection.swift
//  bookbookscraping
//
//  Created by 오민호 on 2018. 6. 8..
//  Copyright © 2018년 오민호. All rights reserved.
//

import Foundation

//https://gist.github.com/silvers/e611dc037f42361ee335
extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
