//
//  AppDelegate.swift
//  CIFIlterSampler
//
//  Created by Shota Nakagami on 2018/07/16.
//  Copyright © 2018年 Shota Nakagami. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = FilterListViewController()
        window?.makeKeyAndVisible()
        return true
    }

}


