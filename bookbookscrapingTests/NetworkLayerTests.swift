//
//  bookbookscrapingTests.swift
//  bookbookscrapingTests
//
//  Created by 오민호 on 2018. 5. 17..
//  Copyright © 2018년 오민호. All rights reserved.
//

import XCTest
@testable import Moya
@testable import bookbookscraping

class NetworkLayerTests: XCTestCase {
    func test_ExpectStatusCodeIsBetween200And300() {
        let expectedStatusCodeIsBetween200And300 = expectation(description: "상태코드 200 ~ 300 와야 함")
        NetworkAdaptor.request(target: .reviews(provider: .naverbooks, isbn: "123456789"),
                               successHandler: { (_) in
                                expectedStatusCodeIsBetween200And300.fulfill()
        }, errorHandler: { (error) in
            XCTFail("\(error.localizedDescription)")
        }, failureHandler: { (error) in
            XCTFail("\(error.localizedDescription)")
        })
        wait(for: [expectedStatusCodeIsBetween200And300], timeout: 1)
    }
}
