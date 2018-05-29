//
//  ServerAPI.swift
//  bookbookscraping
//
//  Created by 오민호 on 2018. 5. 17..
//  Copyright © 2018년 오민호. All rights reserved.
//

import Foundation
import Moya

typealias ISBN = String

enum RestAPI {
    enum BookSortOption : String {
        case sim
        case date
    }
    case reviews(bookstore : Bookstore, isbn : ISBN)
    case books(query : String, start : Int, display : Int, sortOption : BookSortOption)
}

extension RestAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .reviews:
            return NetworkConstants.Review.baseURL
        case .books:
            return NetworkConstants.NaverBook.baseURL
        }
    }
    var path: String {
        switch self {
        case .reviews(_, let isbn):
            return "/reviews/\(isbn)"
        case .books:
            return "/v1/search/book.json"
        }
    }
    var method: Moya.Method {
        return .get
    }
    var sampleData: Data {
        switch self {
        case .reviews:
            return "sample Data".data(using: .utf8)!
        case .books:
            guard let url = Bundle.main.url(forResource: "NaverBookAPISample",
                                            withExtension: "json"),
                let data = try? Data(contentsOf: url) else {
                    return Data()
            }
            return data
        }
    }
    var task: Task {
        switch self {
        case .reviews(let bookstore, _):
            return .requestParameters(parameters: ["bookstore": bookstore.name],
                                      encoding: URLEncoding.default)
        case .books(let query, let start, let display, let sortOption):
            let parameters : [String : Any] = [
                        "query" : query,
                        "start" : start,
                        "display" : display,
                        "sort" : sortOption
            ]
            return .requestParameters(parameters: parameters,
                                      encoding: URLEncoding.default)
        }
    }
    var headers: [String: String]? {
        switch self {
        case .books:
            return [
                "X-Naver-Client-Id" : NetworkConstants.NaverBook.clientID,
                "X-Naver-Client-Secret" : NetworkConstants.NaverBook.secret
            ]
        default:
            return nil
        }
    }
}
