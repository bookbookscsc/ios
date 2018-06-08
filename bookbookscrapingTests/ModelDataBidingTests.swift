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
        let testAPI = RestAPI.naverbookSearch(query: "머신러닝",
                                              start: 10,
                                              display: 20,
                                              sortOption: .sim)
        provider.request(testAPI) { (result) in
            switch result {
            case .success(let response):
                do {
                    let bookAPIResponse = try response.map(BookAPIResponse.self)
                    XCTAssertEqual(20, bookAPIResponse.books.count)
                    XCTAssertEqual(9791161750538, bookAPIResponse.books[4].isbn13)
                    XCTAssertEqual(9791158390334, bookAPIResponse.books[10].isbn13)
                    XCTAssertEqual(9788960779877, bookAPIResponse.books[15].isbn13)
                } catch let error {
                    XCTFail(error.localizedDescription)
                }
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
    func test_BookManager의_SampleTredingBooks에_책들이_정상적으로_바인딩_되어야함() {
        guard let sampleTrendingBooks = BookManager.shared.sampleTrendingBooks else {
            XCTFail("SampleTrendingBooks.json을 [Book] 으로 매핑하는데 실패함")
            return
        }
        XCTAssertEqual(10, sampleTrendingBooks.count)
        XCTAssertEqual(9791195581191, sampleTrendingBooks[0].isbn13)
        XCTAssertEqual(9788968488184, sampleTrendingBooks[5].isbn13)
        XCTAssertEqual(9791185890906, sampleTrendingBooks[9].isbn13)
    }
}
