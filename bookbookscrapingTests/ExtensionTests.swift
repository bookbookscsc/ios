//
//  ExtensionDataTests.swift
//  bookbookscrapingTests
//
//  Created by 오민호 on 2018. 6. 8..
//  Copyright © 2018년 오민호. All rights reserved.
//

import XCTest
@testable import bookbookscraping

class ExtensionDataTests: XCTestCase {
    func test_MainBundle에_존재하는_파일에서_데이터를_가져와야함() {
        let data = Data.fromMainBundle(name: "NaverBookAPISample", ext: "json")
        XCTAssertNotNil(data)
    }
}

class ExtensionArrayTests: XCTestCase {
    func test_Array의_인덱스범위를_넘는_값은_nil_이어야함() {
        let testArray = [1, 2, 3]
        XCTAssertNil(testArray[safe: 3])
        XCTAssertNil(testArray[safe: -1])
        XCTAssertNotNil(testArray[safe: 1])
    }
}

class ExtensionPresentableAlert: XCTestCase {
    class MockViewContrller : UIViewController {
        var isPresentAlert : Bool = false
        override func presentAlert(title: String?, message: String?, preferredStyle: UIAlertControllerStyle) {
            self.isPresentAlert = true
        }
    }
    func test_ViewController들은_Alert을_띄울수_있다() {
        let vcUnderTest = MockViewContrller()
        vcUnderTest.presentAlert(title: "test", message: "test", preferredStyle: .alert)
        XCTAssertTrue(vcUnderTest.isPresentAlert)
    }
}
