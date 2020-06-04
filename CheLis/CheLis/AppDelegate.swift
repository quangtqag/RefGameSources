//
//  AppDelegate.swift
//  CheLis
//
//  Created by Quang Tran on 4/6/19.
//  Copyright © 2019 Quang Tran. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
    window?.backgroundColor = .white
    
    FirebaseApp.configure()
    Database.database().isPersistenceEnabled = true
    
    FBSDKApplicationDelegate.sharedInstance()?.application(application, didFinishLaunchingWithOptions: launchOptions)
    
    GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
    
    return true
  }

  func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
    if (FBSDKApplicationDelegate.sharedInstance()?.application(app, open: url, options: options))! {
      return true
    }
    else if GIDSignIn.sharedInstance().handle(
      url,
      sourceApplication:options[.sourceApplication] as? String, annotation: [:]
      ) {
      return true
    }
    
    return false
  }

}

