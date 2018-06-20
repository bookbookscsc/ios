//
//  TrendingBookStore.swift
//  bookbookscraping
//
//  Created by 오민호 on 2018. 6. 6..
//  Copyright © 2018년 오민호. All rights reserved.
//

import Foundation

enum BookType : Int {
    case trending
    case newRelease
    case bestseller
    case marked
    var title : String {
        switch self {
        case .bestseller:
            return "Best Seller"
        case .trending:
            return "Trending"
        case .newRelease:
            return "New Release"
        case .marked:
            return "Marked"
        }
    }
}

enum BookAction {
    case marked(Book)
}

class BookDataStore {
    static let shared : BookDataStore = BookDataStore()
    private var tredingBooks : [Book] = [Book]()
    private var bestsellers : [Book] = [Book]()
    private var newRelease : [Book] = [Book]()
    private var markedBooks : [Book] = [Book]()
    private let updateQueue = DispatchQueue(label: "bookManager.updateQueue",
                                            attributes: .concurrent)
    lazy var sampleTrendingBooks : [Book]? = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
        return try? jsonDecoder.decode(BookListResponse.self,
                                       from: Data.fromMainBundle(name: "SampleTrendingBooks",
                                                                 ext: "json")).item
    }()
    lazy var sampleBook : Book? = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
        return try? jsonDecoder.decode(Book.self,
                                       from: Data.fromMainBundle(name: "SampleBook",
                                                                 ext: "json"))
    }()
    func count(_ bookType : BookType) -> Int {
        switch bookType {
        case .trending: return tredingBooks.count
        case .bestseller: return bestsellers.count
        case .newRelease: return newRelease.count
        case .marked: return markedBooks.count
        }
    }
    func update(type : BookType, books : [Book]) {
        updateQueue.async(flags: .barrier) {
            switch type {
            case .trending:
                self.tredingBooks = books
            case .bestseller:
                self.bestsellers = books
            case .newRelease:
                self.newRelease = books
            default: return
            }
        }
    }
    func book(type : BookType, idx : Int) -> Book? {
        switch type {
        case .trending: return tredingBooks[safe: idx]
        case .bestseller: return bestsellers[safe: idx]
        case .newRelease: return newRelease[safe: idx]
        case .marked: return markedBooks[safe: idx]
        }
    }
    func add(_ bookAction : BookAction) {
        switch bookAction {
        case .marked(let book):
            markedBooks.append(book)
        }
    }
    func remove(_ bookAction : BookAction) {
        switch bookAction {
        case .marked(let book):
            if let idx = markedBooks.index(of: book) {
                markedBooks.remove(at: idx)
            }
        }
    }
    func save() {}
    func load() {}
}
