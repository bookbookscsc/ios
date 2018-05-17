//
//  ReviewProvider.swift
//  bookbookscraping
//
//  Created by 오민호 on 2018. 5. 18..
//  Copyright © 2018년 오민호. All rights reserved.
//

import Foundation

enum ReviewProvider : String {
    case naverbooks
    case kyobo
    var name : String {
        return self.rawValue
    }
}
