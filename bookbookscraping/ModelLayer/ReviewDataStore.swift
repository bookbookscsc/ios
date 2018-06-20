//
//  ReviewManager.swift
//  bookbookscraping
//
//  Created by 오민호 on 2018. 6. 18..
//  Copyright © 2018년 오민호. All rights reserved.
//

import Foundation

class ReviewDataStore {
    enum ItemType {
        case review
        case reviewMeta
    }
    private var reviewCache = [ISBN13 : Set<Review>]()
    private var reviewMetaCache = [ISBN13 : [ReviewMeta]]()
    lazy var sampleReviewResponse : ReviewListResponse? = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
        return try? jsonDecoder.decode(ReviewListResponse.self,
                                       from: Data.fromMainBundle(name: "SampleReviews",
                                                                 ext: "json"))
    }()
    func add(_ items: [Review], of isbn13 : ISBN13) {
        if let previousReviews = reviewCache[isbn13] {
            _ = previousReviews.union(previousReviews)
            return
        }
        reviewCache[isbn13] = Set<Review>(items)
    }
    func update<T : ReviewItem>(_ items: [T], of isbn13 : ISBN13) {
        if let items = items as? [Review] {
            reviewCache[isbn13] = Set<Review>(items)
        } else if let items = items as? [ReviewMeta] {
            reviewMetaCache[isbn13] = items
        }
    }
    func review(of isbn13 : ISBN13, idx : Int) -> Review? {
        guard let reviewSet = self.reviewCache[isbn13] else {
            return nil
        }
        return [Review](reviewSet)[safe: idx]
    }
    func reviewMeta(of isbn13 : ISBN13, idx : Int) -> ReviewMeta? {
        return reviewMetaCache[isbn13]?[safe: idx]
    }
    func count(_ itemType : ItemType, of isbn13 : ISBN13) -> Int? {
        switch itemType {
        case .review: return reviewCache[isbn13]?.count
        case .reviewMeta: return reviewMetaCache[isbn13]?.count
        }
    }
}
