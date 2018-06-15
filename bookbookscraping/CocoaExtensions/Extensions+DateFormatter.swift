//
//  Extensions+DateFormatter.swift
//  bookbookscraping
//
//  Created by 오민호 on 2018. 6. 15..
//  Copyright © 2018년 오민호. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let forAladin: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MM yyyy HH:mm:ss zzz"
        return formatter
    }()
    static let yyyyMMdd : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
}
