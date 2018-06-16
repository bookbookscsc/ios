//
//  Book.swift
//  bookbookscraping
//
//  Created by 오민호 on 2018. 5. 29..
//  Copyright © 2018년 오민호. All rights reserved.
//

import Foundation

// custom codable with dates
// https://useyourloaf.com/blog/swift-codable-with-custom-dates/

struct BookListResponse: Codable {
    let version : String?
    let logo : URL?
    let pubDate : Date?
    let startIndex : Int?
    let item : [Book]
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        version = try container.decodeIfPresent(String.self, forKey: .version)
        logo = try container.decodeIfPresent(URL.self, forKey: .logo)
        startIndex = try container.decodeIfPresent(Int.self, forKey: .startIndex)
        item = try container.decode([Book].self, forKey: .item)
        if let dateString = try container.decodeIfPresent(String.self, forKey: .pubDate) {
            let formatter = DateFormatter.forAladin
            if let date = formatter.date(from: dateString) {
                pubDate = date
            } else {
                throw DecodingError.dataCorruptedError(forKey: .pubDate,
                                                       in: container,
                                                       debugDescription:
                    "Date string does not match format expected by formatter.")
            }
        } else {
            pubDate = nil
        }
    }
}

struct Book: Codable, Hashable {
    let title : String
    let link : URL? = nil
    let author : String
    let pubDate : Date
    let description : String
    let isbn10 : String
    let isbn13 : String
    let itemId : Int? = nil
    let priceSales : Int? = nil
    let coverLink : URL?
    let bestDuration : String? = nil
    let bestRank : Int? = nil
    let reviewCount : Int? = nil
    var hashValue: Int {
        return Int(isbn13) ?? Int(isbn10) ?? title.hashValue
    }
    enum CodingKeys: String, CodingKey {
        case isbn10 = "isbn"
        case coverLink = "cover"
        case title, link, author, pubDate, description, isbn13, itemId, priceSales, bestDuration, bestRank
    }
}
