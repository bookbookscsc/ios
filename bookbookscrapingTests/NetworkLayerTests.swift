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
    // MARK: Network Test (Expect Status Code : 200)
//    func test_리뷰리스트API_상태코드_200이_와야함() {
//        self.expectStatusCode200(api: .reviews(bookstore: .naverbook,
//                                               isbn: "9788937475313"))
//    }
    func test_네이버책검색API_상태코드_200이_와야함() {
        self.expectStatusCode200(api: .naverbookSearch(query: "머신러닝",
                                                       start : 1,
                                                       display : 10,
                                                       sortOption : .sim))
    }
    func test_알라딘_신간api_상태코드_200이_와야함() {
        self.expectStatusCode200(api: .aladin(type: .bestseller,
                                              start: 1,
                                              display: 10))
    }
    func test_트렌딩_북_api_상태코드_200이_와야함() {
        self.expectStatusCode200(api: .trendings)
    }
    func expectStatusCode200(api : RestAPI) {
        let expectedStatusCodeIsBetween200And300 = expectation(description: "상태코드 200 ~ 300 와야 함")
        NetworkAdaptor.request(target: api,
                               successHandler: { (_) in
                                expectedStatusCodeIsBetween200And300.fulfill()
        }, errorHandler: { (error) in
            XCTFail("\(error.localizedDescription)")
        }, failureHandler: { (error) in
            XCTFail("\(error.localizedDescription)")
        })
        wait(for: [expectedStatusCodeIsBetween200And300], timeout: 5)
    }
}
