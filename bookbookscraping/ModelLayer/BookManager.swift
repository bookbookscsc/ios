//
//  TrendingBookStore.swift
//  bookbookscraping
//
//  Created by 오민호 on 2018. 6. 6..
//  Copyright © 2018년 오민호. All rights reserved.
//

import Foundation

enum BookType : Int {
    case bestseller
    case newRelease
    case trending
    case marked
}

enum BookAction {
    case marked(Book)
}

class BookManager {
    static let shared : BookManager = BookManager()
    private var tredingBooks : [Book] = [Book]()
    private var bestsellers : [Book] = [Book]()
    private var newRelease : [Book] = [Book]()
    private var markedBooks : [Book] = [Book]()
    lazy var sampleTrendingBooks : [Book]? = {
        guard let url = Bundle.main.url(forResource: "SampleTrendingBooks",
                                        withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        return try? JSONDecoder().decode([Book].self, from: data)
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
