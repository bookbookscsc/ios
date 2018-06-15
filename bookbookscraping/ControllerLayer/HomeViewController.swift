//
//  ViewController.swift
//  bookbookscraping
//
//  Created by 오민호 on 2018. 5. 17..
//  Copyright © 2018년 오민호. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet var containerTableView : UITableView!
    private var occurNetworkError = false
    private var updateBooksGroup : DispatchGroup = DispatchGroup()
    private let resonseDecoder : JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
        return jsonDecoder
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        occurNetworkError = false
        updateTrendingBooks()
        updateNewReleaseAndBestSeller()
        updateBooksGroup.notify(queue: .main) {
            if self.occurNetworkError {
                self.presentAlert(title: "네트워크 오류", message: "네트워크 상 오류로 인하여 책 정보를 가져오지 못했습니다")
            }
        }
    }
    // todo: 일정시간동안 Cache 구현
    /// Trending Book을 서버에서 가져와서 화면에 Update
    private func updateTrendingBooks() {
        updateBooksGroup.enter()
        NetworkAdaptor.request(target: .trendings,
                               successHandler: { (response) in
                                guard let books = try? response.map([Book].self,
                                                                    using: self.resonseDecoder) else {
                                    return
                                }
                                BookManager.shared.update(type: .trending,
                                                          books: books)
                                self.updateBooksGroup.leave()
                                DispatchQueue.main.async {
                                    self.containerTableView.reloadSections(IndexSet(integer: 0),
                                                                           with: .automatic)
                                }
        }, errorHandler: { (_) in
            self.occurNetworkError = true
            self.updateBooksGroup.leave()
        }, failureHandler: { (_) in
            self.occurNetworkError = true
            self.updateBooksGroup.leave()
        })
    }
    // todo: 일정시간동안 Cache 구현
    /// 신간, 베스트셀러들를 알라딘 API로 가져와서 화면에 Update
    private func updateNewReleaseAndBestSeller() {
        let apiTypes : [(RestAPI.AladinAPIType, BookType)] = [(.newRelease, .newRelease),
                                                              (.bestseller, .bestseller)]
        for (apitype, bookType) in apiTypes {
            updateBooksGroup.enter()
            NetworkAdaptor.request(target: .aladin(type: apitype,
                                                   start: 1,
                                                   display: 10), successHandler: { (response) in
                                                    guard let bookAPIResponse = try? response.map(AladinResponse.self,
                                                                                                  using: self.resonseDecoder)
                                                        else {
                                                        return
                                                    }
                                                    self.updateBooksGroup.leave()
                                                    BookManager.shared.update(type: bookType,
                                                                              books: bookAPIResponse.item)
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
                self.updateBooksGroup.leave()
            }, failureHandler: { (_) in
                self.occurNetworkError = true
                self.updateBooksGroup.leave()
            })
        }
    }
}
