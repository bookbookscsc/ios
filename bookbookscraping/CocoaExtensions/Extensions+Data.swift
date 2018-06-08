//
//  Extensions+Data.swift
//  bookbookscraping
//
//  Created by 오민호 on 2018. 6. 8..
//  Copyright © 2018년 오민호. All rights reserved.
//

import Foundation

extension Data {
    public static func fromMainBundle(name: String, ext: String) -> Data {
        guard let url = Bundle.main.url(forResource: name,
                                        withExtension: ext),
            let data = try? Data(contentsOf: url) else {
                return Data()
        }
        return data
    }
}
