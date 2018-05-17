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
        return .requestPlain
    }
    var headers: [String: String]? {
        switch self {
        case .reviews(let provider, let isbn):
            return [
                "provider": provider.rawValue,
                "isbn": isbn
            ]
        }
    }
}
