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
    var bookDataStore : BookDataStore = BookDataStore.shared
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        bookDataStore.load()
        return true
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        bookDataStore.save()
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        bookDataStore.load()
    }
}
