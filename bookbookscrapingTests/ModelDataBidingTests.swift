//
//  ModelDataBidingTest.swift
//  bookbookscrapingTests
//
//  Created by 오민호 on 2018. 5. 29..
//  Copyright © 2018년 오민호. All rights reserved.
//

import XCTest
@testable import Moya
@testable import Result
@testable import bookbookscraping

class ModelDataBidingTests: XCTestCase {
    var provider : MoyaProvider<RestAPI>!
    var jsonDecoder : JSONDecoder!
    override func setUp() {
        provider = MoyaProvider<RestAPI>(stubClosure: MoyaProvider.immediatelyStub)
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
        self.jsonDecoder = jsonDecoder
    }
    func test_bookDataStore의_SampleTredingBooks에_책들이_정상적으로_바인딩_되어야함() {
        guard let sampleTrendingBooks = BookDataStore.shared.sampleTrendingBooks else {
            XCTFail("SampleTrendingBooks.json을 [Book] 으로 매핑하는데 실패함")
            return
        }
        XCTAssertEqual(10, sampleTrendingBooks.count)
        let firstExpectedDate = DateFormatter.yyyyMMdd.date(from: "2018-06-11")
        let firstCoverLink = URL(string: "http://image.aladin.co.kr/product/14954/99/coversum/8976130502_1.jpg")
        XCTAssertEqual("9788976130501", sampleTrendingBooks[1].isbn13)
        XCTAssertEqual(firstExpectedDate, sampleTrendingBooks[1].pubDate)
        XCTAssertEqual(firstCoverLink, sampleTrendingBooks[1].coverLink)
        let secondExpectedDate = DateFormatter.yyyyMMdd.date(from: "2018-06-20")
        let secondCoverLink = URL(string: "http://image.aladin.co.kr/product/14954/95/coversum/k662533962_1.jpg")
        XCTAssertEqual("9791127845117", sampleTrendingBooks[2].isbn13)
        XCTAssertEqual(secondExpectedDate, sampleTrendingBooks[2].pubDate)
        XCTAssertEqual(secondCoverLink, sampleTrendingBooks[2].coverLink)
    }
    // MARK: - Data Binding Test
    func test_트렌딩북_들이_적절하게_Book에_바인딩_되었는가() {
        let testAPI = RestAPI.trendings
        provider.request(testAPI) { (result) in
            self.bookResponseBindingTest(result: result, expectedCount: 10)
        }
    }
    func test_베스트셀러들이_적절하게_Book에_바인딩_되었는가() {
        let testAPI = RestAPI.aladin(type: .bestseller,
                                     start: 1,
                                     display: 10)
        provider.request(testAPI) { (result) in
            self.bookResponseBindingTest(result: result, expectedCount: 10)
        }
    }
    func test_신간도서들이_적절하게_Book에_바인딩_되었는가() {
        let testAPI = RestAPI.aladin(type: .newRelease,
                                     start: 0,
                                     display: 10)
        provider.request(testAPI) { (result) in
            self.bookResponseBindingTest(result: result, expectedCount: 10)
        }
    }
    func test_리뷰리스트가_적절하게_바인딩_되었는가() {
        let testAPI = RestAPI.reviews(of: "9788976130501")
        provider.request(testAPI) { (result) in
            self.reviewResponseBindingTest(result: result)
        }
    }
    func reviewResponseBindingTest(result : Result<Moya.Response, MoyaError>) {
        switch result {
        case .success(let response):
            do {
                let reviewAPIResponse = try response.map(ReviewListResponse.self,
                                                         using: self.jsonDecoder)
                XCTAssertEqual(2, reviewAPIResponse.item.count)
            } catch let error {
                XCTFail(error.localizedDescription)
            }
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }
    func bookResponseBindingTest(result: Result<Moya.Response, MoyaError>, expectedCount : Int) {
        switch result {
        case .success(let response):
            do {
                let bookAPIResponse = try response.map(BookListResponse.self,
                                                       using: self.jsonDecoder)
                XCTAssertEqual(expectedCount, bookAPIResponse.item.count)
            } catch let error {
                XCTFail(error.localizedDescription)
            }
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }
}
