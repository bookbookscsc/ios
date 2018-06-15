//
//  BookManagerTests.swift
//  bookbookscrapingTests
//
//  Created by 오민호 on 2018. 6. 6..
//  Copyright © 2018년 오민호. All rights reserved.
//

import XCTest
@testable import bookbookscraping

class BookManagerTests: XCTestCase {
    var trendingBooksFromServer : [Book]!
    var bookManager : BookManager!
    override func setUp() {
        super.setUp()
        bookManager = BookManager()
        trendingBooksFromServer = bookManager.sampleTrendingBooks
    }
    func test_TrendingBook이_올바르게_업데이트_초기화돼야함() {
        bookManager.update(type: .trending, books: trendingBooksFromServer)
        let expectedBook = trendingBooksFromServer[0]
        XCTAssertEqual(expectedBook, bookManager.book(type: .trending, idx: 0))
    }
    func test_MarkedBooks의_길이는_0으로_초기화돼야함() {
        XCTAssertEqual(0, bookManager.count(.marked))
    }
    func test_MarkedBook을_추가하면_길이가_1이_증가해야함() {
        guard let book = bookManager.sampleBook else {
            XCTFail("SampleBook is Nil")
            return
        }
        bookManager.add(.marked(book))
        XCTAssertEqual(1, bookManager.count(.marked))
    }
    func test_MarkedBook에_있는_데이터를_삭제하면_길이가_1_감소해야함() {
        guard let book = bookManager.sampleBook else {
            XCTFail("SampleBook is Nil")
            return
        }
        bookManager.add(.marked(book))
        bookManager.remove(.marked(book))
        let expected = 0
        XCTAssertEqual(expected, bookManager.count(.marked))
    }
}
