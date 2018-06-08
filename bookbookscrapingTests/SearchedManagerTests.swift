//
//  SearchedManagerTests.swift
//  bookbookscrapingTests
//
//  Created by 오민호 on 2018. 6. 8..
//  Copyright © 2018년 오민호. All rights reserved.
//

import XCTest
@testable import bookbookscraping

class SearchedManagerTests: XCTestCase {
    var searchManager : SearchManager!
    override func setUp() {
        super.setUp()
        searchManager = SearchManager()
    }
    func test_SearchedKeywords의_길이는_0으로_초기화돼야함() {
        XCTAssertEqual(0, searchManager.count)
    }
    func test_SearchedKeyword를_추가하면_길이가_1이_증가해야함() {
        searchManager.insert(keyword: "머신러닝")
        XCTAssertEqual(1, searchManager.count)
    }
    func test_똑같은_키워드를_중복해서_저장하지_말아야함() {
        searchManager.insert(keyword: "머신러닝")
        XCTAssertEqual(1, searchManager.count)
        searchManager.insert(keyword: "머신러닝")
        XCTAssertEqual(1, searchManager.count)
    }
    func test_이전에_검색했던_키워드들이_특정단어의_포함유무에_따라_필터링_돼야함() {
        let searchingKeywords = ["머신러닝", "딥러닝", "CNN"]
        for keyword in searchingKeywords {
            searchManager.insert(keyword: keyword)
        }
        let expectedSet = Set<String>(["머신러닝", "딥러닝"])
        XCTAssertEqual(expectedSet, searchManager.filtered(string: "러닝"))
    }
}
