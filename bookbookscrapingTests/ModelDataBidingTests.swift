//
//  ModelDataBidingTest.swift
//  bookbookscrapingTests
//
//  Created by 오민호 on 2018. 5. 29..
//  Copyright © 2018년 오민호. All rights reserved.
//

import XCTest
@testable import Moya
@testable import bookbookscraping

class ModelDataBidingTests: XCTestCase {
    var provider : MoyaProvider<RestAPI>!
    override func setUp() {
        provider = MoyaProvider<RestAPI>(stubClosure: MoyaProvider.immediatelyStub)
    }
    // MARK: - Data Binding Test
    func test_네이버책검색API_전송받은_json_이_Book_Model에_적절하게_바인딩_되어야함() {
        let testAPI = RestAPI.books(query: "머신러닝",
                                    start: 10,
                                    display: 20,
                                    sortOption: .sim)
        provider.request(testAPI) { (result) in
            switch result {
            case .success(let response):
                do {
                    let bookAPIResponse = try response.map(BookAPIResponse.self)
                    XCTAssertEqual(20, bookAPIResponse.books.count)
                    XCTAssertEqual(bookAPIResponse.books[4].isbn13, 9791161750538)
                    XCTAssertEqual(bookAPIResponse.books[10].isbn13, 9791158390334)
                    XCTAssertEqual(bookAPIResponse.books[15].isbn13, 9788960779877)
                } catch let error {
                    XCTFail(error.localizedDescription)
                }
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
}
