//
//  SearchManager.swift
//  bookbookscraping
//
//  Created by 오민호 on 2018. 6. 8..
//  Copyright © 2018년 오민호. All rights reserved.
//

import Foundation

class SearchManager {
    private var searchedKeyword : Set<String> = Set()
    func insert(keyword : String) {
        self.searchedKeyword.insert(keyword)
    }
    func clear(keyword : String) {
        self.searchedKeyword.removeAll()
    }
    func filtered(string : String) -> Set<String> {
        return self.searchedKeyword.filter {
            $0.contains(string)
        }
    }
    var count : Int {
        return self.searchedKeyword.count
    }
}
