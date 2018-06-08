//
//  AppDelegate.swift
//  bookbookscraping
//
//  Created by 오민호 on 2018. 5. 17..
//  Copyright © 2018년 오민호. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var bookManager : BookManager = BookManager.shared
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        bookManager.load()
        return true
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        bookManager.save()
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        bookManager.load()
    }
}
