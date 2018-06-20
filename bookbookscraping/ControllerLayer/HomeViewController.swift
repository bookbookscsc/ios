//
//  ViewController.swift
//  bookbookscraping
//
//  Created by 오민호 on 2018. 5. 17..
//  Copyright © 2018년 오민호. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var containerTableView : UITableView!
    @IBOutlet var bookDataProvider : BookDataProvider!
    private var occurNetworkError = false
    private var requestBooksGroup : DispatchGroup = DispatchGroup()
    private let responseDecoder : JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
        return jsonDecoder
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        bookDataProvider.viewController = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        occurNetworkError = false
        requestTrendingBooks()
        requestNewReleaseAndBestSeller()
        requestBooksGroup.notify(queue: .main) {
            if self.occurNetworkError {
                self.presentAlert(title: "네트워크 오류", message: "네트워크 상 오류로 인하여 책 정보를 가져오지 못했습니다")
            }
        }
    }
    /// Trending Book을 서버에서 가져와서 화면에 Update,
    /// Response Cache-Control is max-age=300
    private func requestTrendingBooks() {
        requestBooksGroup.enter()
        NetworkAdaptor.request(target: .trendings,
                               successHandler: { (response) in
                                guard let response = try? response.map(BookListResponse.self,
                                                                    using: self.responseDecoder) else {
                                    return
                                }
                                BookDataStore.shared.update(type: .trending,
                                                            books: response.item)
                                self.requestBooksGroup.leave()
                                DispatchQueue.main.async {
                                    self.containerTableView.reloadSections(IndexSet(integer: 0),
                                                                           with: .automatic)
                                }
        }, errorHandler: { (_) in
            self.occurNetworkError = true
            self.requestBooksGroup.leave()
        }, failureHandler: { (_) in
            self.occurNetworkError = true
            self.requestBooksGroup.leave()
        })
    }
    // todo: 일정시간동안 Cache 구현
    /// 신간, 베스트셀러들를 알라딘 API로 가져와서 화면에 Update
    private func requestNewReleaseAndBestSeller() {
        let apiTypes : [(RestAPI.AladinAPIType, BookType)] = [(.newRelease, .newRelease),
                                                              (.bestseller, .bestseller)]
        for (apitype, bookType) in apiTypes {
            requestBooksGroup.enter()
            NetworkAdaptor.request(target: .aladin(type: apitype,
                                                   start: 1,
                                                   display: 9),
                                   successHandler: { (response) in
                                    guard let bookAPIResponse = try? response.map(BookListResponse.self,
                                                                                  using: self.responseDecoder)
                                        else {
                                            return
                                    }
                                    BookDataStore.shared.update(type: bookType,
                                                              books: bookAPIResponse.item)
                                    self.requestBooksGroup.leave()
                                    DispatchQueue.main.async {
                                        switch bookType {
                                        case .newRelease:
                                            self.containerTableView.reloadSections(IndexSet(integer: 1),
                                                                                   with: .automatic)
                                        case .bestseller:
                                            self.containerTableView.reloadSections(IndexSet(integer: 2),
                                                                                   with: .automatic)
                                        default: return
                                        }
                                    }
            }, errorHandler: { (_) in
                self.occurNetworkError = true
                self.requestBooksGroup.leave()
            }, failureHandler: { (_) in
                self.occurNetworkError = true
                self.requestBooksGroup.leave()
            })
        }
    }
}
