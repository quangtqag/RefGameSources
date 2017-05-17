//
//  AppDelegate.swift
//  FlickrSearch
//
//  Created by Richard Turton on 30/06/2016.
//  Copyright © 2016 Richard Turton. All rights reserved.
//

import UIKit

let themeColor = UIColor(red: 0.01, green: 0.41, blue: 0.22, alpha: 1.0)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    window?.tintColor = themeColor
    return true
  }
}

