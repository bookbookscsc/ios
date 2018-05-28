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
    case reviews(bookstore : Bookstore, isbn : ISBN)
    case books(query : String)
}

extension RestAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .reviews:
            return URL(string: ReviewAPI.baseURLString.rawValue)!
        case .books:
            return URL(string: NaverBookAPI.baseURLString.rawValue)!
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
        return Data()
    }
    var task: Task {
        switch self {
        case .reviews(let bookstore, _):
            return .requestParameters(parameters: ["bookstore": bookstore.name],
                                      encoding: URLEncoding.default)
        case .books(let query):
            return .requestParameters(parameters: ["query": query],
                                      encoding: URLEncoding.default)
        }
    }
    var headers: [String: String]? {
        switch self {
        case .books:
            return [
                "X-Naver-Client-Id" : NaverBookAPI.clientID.rawValue,
                "X-Naver-Client-Secret" : NaverBookAPI.secret.rawValue
            ]
        default:
            return nil
        }
    }
}
