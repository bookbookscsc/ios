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
    enum NaverbookSortOption : String {
        case sim
        case date
    }
    enum AladinAPIType {
        case bestseller
        case newRelease
        var parameters : [String : String] {
            var parameters = [
                "ttbkey" : NetworkConstants.Aladin.secret,
                "Version" : "20131101",
                "Output" : "JS",
                "SearchTarget" : "Book"
                ]
            switch self {
            case .bestseller:
                parameters["QueryType"] = "Bestseller"
                return parameters
            case .newRelease:
                parameters["QueryType"] = "ItemNewAll"
                return parameters
            }
        }
    }
    case reviews(bookstore : Bookstore, isbn : ISBN)
    case naverbookSearch(query: String, start: Int, display: Int, sortOption: NaverbookSortOption)
    case aladin(type : AladinAPIType, start: Int, display: Int)
}

extension RestAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .reviews:
            return NetworkConstants.Review.baseURL
        case .naverbookSearch:
            return NetworkConstants.NaverBook.baseURL
        case .aladin:
            return NetworkConstants.Aladin.baseURL
        }
    }
    var path: String {
        switch self {
        case .reviews(_, let isbn):
            return "/reviews/\(isbn)"
        case .naverbookSearch:
            return "/v1/search/book.json"
        case .aladin:
            return "/ItemList.aspx"
        }
    }
    var method: Moya.Method {
        return .get
    }
    var sampleData: Data {
        switch self {
        case .reviews:
            return "sample Data".data(using: .utf8)!
        case .naverbookSearch:
            return Data.fromMainBundle(name: "NaverBookAPISample", ext: "json")
        case .aladin(let apiType, _, _):
            switch apiType {
            case .bestseller:
                return Data.fromMainBundle(name: "BestSellerSample", ext: "json")
            case .newRelease:
                return Data.fromMainBundle(name: "NewReleaseSample", ext: "json")
            }
        }
    }
    var task: Task {
        switch self {
        case .reviews(let bookstore, _):
            return .requestParameters(parameters: ["bookstore": bookstore.name],
                                      encoding: URLEncoding.default)
        case .naverbookSearch(let query, let start, let display, let sortOption):
            let parameters : [String : Any] = [
                        "query" : query,
                        "start" : start,
                        "display" : display,
                        "sort" : sortOption
            ]
            return .requestParameters(parameters: parameters,
                                      encoding: URLEncoding.default)
        case .aladin(let apiType, let start, let display):
            var parameters = apiType.parameters
            parameters["start"] = "\(start)"
            parameters["MaxResults"] = "\(display)"
            return .requestParameters(parameters: parameters,
                                      encoding: URLEncoding.default)
        }
    }
    var headers: [String: String]? {
        switch self {
        case .naverbookSearch:
            return [
                "X-Naver-Client-Id" : NetworkConstants.NaverBook.clientID,
                "X-Naver-Client-Secret" : NetworkConstants.NaverBook.secret
            ]
        default:
            return nil
        }
    }
}
