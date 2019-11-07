//
//  AppDelegate.swift
//  RxSnapKit
//
//  Created by ido on 2019/11/07.
//  Copyright © 2019 ido. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = {
            let window = UIWindow(frame: UIScreen.main.bounds)
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = [
                SliderViewController(),
                LeftRightViewController()
            ]
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
            return window
        }()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}

