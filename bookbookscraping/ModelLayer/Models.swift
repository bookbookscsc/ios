//
//  Book.swift
//  bookbookscraping
//
//  Created by 오민호 on 2018. 5. 29..
//  Copyright © 2018년 오민호. All rights reserved.
//

import Foundation

struct AladinResponse: Codable {
    let version : String
    let logo : URL
    let pubDate : String
    let startIndex : Int
    let item : [Book]
}

struct Book: Codable, Hashable {
    let title : String
    let link : URL?
    let author : String
    let pubDate : String
    let description : String
    let isbn10 : String
    let isbn13 : String
    let itemId : Int
    let priceSales : Int
    let coverLink : URL?
    let bestDuration : String? = nil
    let bestRank : Int? = nil
    var hashValue: Int {
        return Int(isbn13) ?? Int(isbn10) ?? title.hashValue
    }
    enum CodingKeys: String, CodingKey {
        case isbn10 = "isbn"
        case coverLink = "cover"
        case title, link, author, pubDate, description, isbn13, itemId, priceSales, bestDuration, bestRank
    }
    init(title: String,
         link: URL? = nil,
         author: String = "",
         pubDate: String = "",
         description: String = "",
         isbn10: String = "",
         isbn13 : String = "",
         itemId : Int = 0,
         priceSales : Int = 0,
         coverLink: URL? = nil) {
        self.title = title
        self.link = link
        self.author = author
        self.pubDate = pubDate
        self.description = description
        self.isbn10 = isbn10
        self.isbn13 = isbn13
        self.itemId = itemId
        self.priceSales = priceSales
        self.coverLink = coverLink
    }
}
