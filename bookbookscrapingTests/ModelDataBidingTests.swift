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
    func test_알라딘_Bestseller_API() {
        let testAPI = RestAPI.aladin(type: .bestSeller,
                                     start: 1,
                                     display: 10)
        provider.request(testAPI) { (result) in
            switch result {
            case .success(let response):
                do {
                    let bookAPIResponse = try response.map(AladinResponse.self)
                    XCTAssertEqual(10, bookAPIResponse.item.count)
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
        XCTAssertEqual("9788976130501", sampleTrendingBooks[1].isbn13)
        XCTAssertEqual("9791127845117", sampleTrendingBooks[2].isbn13)
    }
}
