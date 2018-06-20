//
//  BookDetailViewControllerTests.swift
//  bookbookscrapingTests
//
//  Created by 오민호 on 2018. 6. 15..
//  Copyright © 2018년 오민호. All rights reserved.
//

import XCTest
@testable import Kingfisher
@testable import bookbookscraping

class BookDetailViewControllerTests: XCTestCase {
    var sut: BookDetailViewController!
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(
            withIdentifier: "BookDetailViewController"
            ) as? BookDetailViewController
        _ = sut.view
    }
    func test_viewWillAppear_할때_책의_isbn13으로_리뷰정보를_가져오는_함수를_실행해야한다() {
        sut.beginAppearanceTransition(true, animated: true)
    }
    func test_책의_디테일_정보를_보여주기위한_view들이_있어야_한다() {
        XCTAssertNotNil(sut.titleLabel)
        XCTAssertNotNil(sut.authorLabel)
        XCTAssertNotNil(sut.publisherLabel)
        XCTAssertNotNil(sut.coverImageView)
    }
    func test_각각의_라벨에는_올바른_책의_정보들이_있어야_한다() {
        let bookManager = BookDataStore.shared
        if let sampleBooks = bookManager.sampleTrendingBooks {
            bookManager.update(type: .trending, books: sampleBooks)
        }
        sut.bookInfo = (BookType.trending, 1)
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        XCTAssertEqual("타인의 시선 - 국부에서 협상가까지, 대한민국 대통령", sut.titleLabel.text)
        XCTAssertEqual("타임TIME, 찰리 캠벨 (지은이), 배현 (옮긴이)", sut.authorLabel.text)
        XCTAssertEqual("유피에이(UPA)", sut.publisherLabel.text)
        XCTAssertEqual("""
http://image.aladin.co.kr/product/14954/99/coversum/8976130502_1.jpg
""", sut.coverImageView.kf.webURL?.absoluteString)
    }
}
