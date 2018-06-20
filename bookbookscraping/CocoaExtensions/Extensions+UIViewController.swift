//
//  Extensions+UIViewController.swift
//  bookbookscraping
//
//  Created by 오민호 on 2018. 6. 13..
//  Copyright © 2018년 오민호. All rights reserved.
//

import UIKit

@objc protocol PresentableAlert {
    func presentAlert(title : String?,
                      message: String?,
                      preferredStyle: UIAlertControllerStyle)
}
extension UIViewController : PresentableAlert {
    func presentAlert(title : String? = nil,
                      message: String? = nil,
                      preferredStyle: UIAlertControllerStyle = .alert) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: preferredStyle)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
