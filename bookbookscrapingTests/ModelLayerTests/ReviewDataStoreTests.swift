//
//  ReviewManagerTests.swift
//  bookbookscrapingTests
//
//  Created by 오민호 on 2018. 6. 19..
//  Copyright © 2018년 오민호. All rights reserved.
//

import XCTest
@testable import bookbookscraping

class ReviewDataStoreTests: XCTestCase {
    var reviewDataStore : ReviewDataStore!
    var sampleReviews : [Review]!
    var sampleReviewMeta : [ReviewMeta]!
    let testIsbn13 = "9788976130501"
    override func setUp() {
        super.setUp()
        reviewDataStore = ReviewDataStore()
        sampleReviews = reviewDataStore.sampleReviewResponse?.item
        sampleReviewMeta = reviewDataStore.sampleReviewResponse?.reviewMeta
    }
    func test_책의_리뷰들을_추가하면_저장된_리뷰의_개수가_늘어나야한다() {
        XCTAssertNil(reviewDataStore.count(.review, of: testIsbn13))
        self.reviewDataStore.add(sampleReviews, of: testIsbn13)
        XCTAssertEqual(2, reviewDataStore.count(.review, of: testIsbn13))
    }
    func test_리뷰는_본문_좋아요수_점수_서점이름을_이용해_구분한다() {
        let review1 = Review(text: "본문", bookStore: .kyobo)
        let review2 = Review(text: "본문", bookStore: .kyobo)
        XCTAssertEqual(review1, review2)
        let review3 = Review(text: "본문",
                             bookStore: .naverbook,
                             rating: 3.4,
                             likes: 4)
        let review4 = Review(text: "본문",
                             bookStore: .naverbook,
                             rating: 3.4,
                             likes: 5)
        XCTAssertNotEqual(review3, review4)
        let review5 = Review(text: "본문",
                             bookStore: .naverbook,
                             rating: 3.4,
                             likes: 4)
        let review6 = Review(text: "본문",
                             bookStore: .naverbook,
                             rating: 3.5,
                             likes: 4)
        XCTAssertNotEqual(review5, review6)
    }
}
