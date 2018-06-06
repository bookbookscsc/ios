//
//  TrendingBookStore.swift
//  bookbookscraping
//
//  Created by 오민호 on 2018. 6. 6..
//  Copyright © 2018년 오민호. All rights reserved.
//

import Foundation

enum BookType {
    case treding
    case searched
    case marked
}

enum BookAction {
    case searched(Book)
    case marked(Book)
}

class BookManager {
    static let shared : BookManager = BookManager()
    private var tredingBooks : [Book] = [Book]()
    private var searchedBooks : [Book] = [Book]()
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
        case .treding: return tredingBooks.count
        case .searched: return searchedBooks.count
        case .marked: return markedBooks.count
        }
    }
    func update(tredingBooks : [Book]) {
        self.tredingBooks = tredingBooks
    }
    func book(type : BookType, idx : Int) -> Book? {
        switch type {
        case .treding: return tredingBooks[idx]
        case .searched: return searchedBooks[idx]
        case .marked: return markedBooks[idx]
        }
    }
    func add(_ bookAction : BookAction) {
        switch bookAction {
        case .searched(let book):
            searchedBooks.append(book)
        case .marked(let book):
            markedBooks.append(book)
        }
    }
    func remove(_ bookAction : BookAction) {
        switch bookAction {
        case .searched(let book):
            if let idx = searchedBooks.index(of: book) {
                searchedBooks.remove(at: idx)
            }
        case .marked(let book):
            if let idx = markedBooks.index(of: book) {
                markedBooks.remove(at: idx)
            }
        }
    }
    func save() {
        
    }
    func load() {
        
    }
}
