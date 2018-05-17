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
    case reviews(provider : ReviewProvider, isbn : ISBN)
}

extension RestAPI: TargetType {
    var baseURL: URL {
        return URL(string: "127.0.0.1")!
    }
    var path: String {
        switch self {
        case .reviews:
            return "/reviews"
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
        case .reviews(let reviewProvider, let isbn):
            return .requestParameters(parameters: ["provider": reviewProvider.name,
                                                   "isbn": isbn],
                                      encoding: JSONEncoding.default)
        }
    }
    var headers: [String: String]? {
        return nil
    }
}
