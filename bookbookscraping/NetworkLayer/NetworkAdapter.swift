//
//  NetworkAdapter.swift
//  bookbookscraping
//
//  Created by 오민호 on 2018. 5. 18..
//  Copyright © 2018년 오민호. All rights reserved.
//

import Foundation
import Moya

struct ServerError : Error {
    let statusCode : Int
}

struct NetworkAdaptor {
    static let provider = MoyaProvider<RestAPI>()
    
    static func request(target : RestAPI,
                        successHandler : @escaping (Response) -> Void,
                        errorHandler : @escaping (ServerError) -> Void,
                        failureHandler : @escaping (MoyaError) -> Void) {
        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                if (200...300).contains(response.statusCode) {
                    successHandler(response)
                } else {
                    errorHandler(ServerError(statusCode: response.statusCode))
                }
            case .failure(let error):
                failureHandler(error)
            }
        }
    }
}
