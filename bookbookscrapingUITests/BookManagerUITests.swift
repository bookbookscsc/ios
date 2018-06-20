//
//  bookbookscrapingUITests.swift
//  bookbookscrapingUITests
//
//  Created by 오민호 on 2018. 6. 6..
//  Copyright © 2018년 오민호. All rights reserved.
//

import XCTest

class BookDataStoreUITests: XCTestCase {
    class FakebookDataStore : BookDataStore {
        var saveWasCalled = false
        var loadWasCalled = false
        override func save() {
            saveWasCalled = true
        }
        override func load() {
            loadWasCalled = true
        }
    }
    var bookDataStore : FakeBookDataStore!
    override func setUp() {
        super.setUp()
        bookDataStore = FakeBookDataStore()
        let app = XCUIApplication()
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.bookDataStore = bookDataStore
        }
        continueAfterFailure = false
    }
    func test_앱이_포그라운드로_올라올때_load메서드가_호출되어야함() {
        XCUIApplication().activate()
        XCTAssertTrue(bookDataStore.loadWasCalled)
    }
    func test_앱이_백그라운드로_넘어갈때_save메서드가_호출되어야함() {
        XCUIDevice().press(XCUIDevice.Button.home)
        XCTAssertTrue(bookDataStore.saveWasCalled)
    }
}
