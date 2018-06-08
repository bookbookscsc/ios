//
//  Book.swift
//  bookbookscraping
//
//  Created by 오민호 on 2018. 5. 29..
//  Copyright © 2018년 오민호. All rights reserved.
//

import Foundation

struct Book : Codable, Hashable {
    let title : String
    let isbnString : String
    let thumbImageURL : URL?
    let author : String
    let price : String?
    let discount : String?
    let publisher : String
    let pubdate : String
    let description : String
    enum CodingKeys: String, CodingKey {
        case isbnString = "isbn"
        case thumbImageURL = "image"
        case title, author, price, discount, publisher, pubdate, description
    }
    var isbn13 : Int? {
        let isbn13String = String(self.isbnString.split(separator: " ").last ?? "")
        if isbn13String.count != 13 {
            return nil
        }
        return Int(isbn13String)
    }
    init(title : String,
         isbnString: String = "",
         thumbImageURL: URL? = nil,
         author: String = "",
         price: String = "",
         discount: String = "",
         publisher: String = "",
         pubdate: String = "",
         description: String = "") {
        self.title = title
        self.isbnString = isbnString
        self.thumbImageURL = thumbImageURL
        self.author = author
        self.price = price
        self.discount = discount
        self.publisher = publisher
        self.pubdate = pubdate
        self.description = description
    }
    var hashValue: Int {
        return isbn13 ?? 0
    }
}

struct BookAPIResponse : Codable {
    let total : Int
    let start : Int
    let display : Int
    let books : [Book]
    enum CodingKeys: String, CodingKey {
        case total, start, display
        case books = "items"
    }
}
