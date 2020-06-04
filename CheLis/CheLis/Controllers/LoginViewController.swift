//
//  LoginViewController.swift
//  CheLis
//
//  Created by Quang Tran on 4/7/19.
//  Copyright © 2019 Quang Tran. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import GoogleSignIn

class LoginViewController: UIViewController {
  var user: User?
  var presentWithAnimation = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.isHidden = true
    Auth.auth().addStateDidChangeListener() { auth, user in
      guard user != nil else {
        self.view.isHidden = false
        return
      }
      
      self.user = User(authData: user!)
      
      let navigationController = self.storyboard!.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
      let listTableViewController = navigationController.viewControllers.first as! ListTableViewController
      listTableViewController.user = self.user
      self.present(navigationController, animated: self.presentWithAnimation, completion: {
        print("✅ Presented list table view controller")
      })
    }
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return UIStatusBarStyle.lightContent
  }
  
  @IBAction func googleLoginButtonDidTap(_ sender: UIButton) {
    GIDSignIn.sharedInstance().delegate = self
    GIDSignIn.sharedInstance().uiDelegate = self
    GIDSignIn.sharedInstance()?.shouldFetchBasicProfile = false
    GIDSignIn.sharedInstance()?.scopes = ["profile"]
    GIDSignIn.sharedInstance().signIn()
  }
  
  @IBAction func facebookLoginButtonDidTap(_ sender: UIButton) {
    FBSDKLoginManager().logIn(
      withReadPermissions: ["public_profile"],
      from: self
    ) { (result, error) in
      guard error == nil else {
        print("🛑 Error when login by Facebook: \(error!)")
        return
      }
      
      guard let result = result,
        result.isCancelled == false else {
          print("Login by Facebook: the user has cancelled")
          return
      }
      
      print("Logged in by Facebook")
      let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
      self.presentWithAnimation = true
      Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
        if let error = error {
          print("🛑 Auth sign in by Facebook credential failed: \(error.localizedDescription)")
          return
        }
      }
    }
  }
}

extension LoginViewController: GIDSignInDelegate {
  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
    
    if let error = error {
      print("🛑 Error when authenticating Google account: \(error.localizedDescription)")
      return
    }
    
    guard let authentication = user.authentication else { return }
    let credential = GoogleAuthProvider.credential(
      withIDToken: authentication.idToken,
      accessToken: authentication.accessToken)
    self.presentWithAnimation = true
    Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
      if let error = error {
        print("🛑 Auth sign in by Google credential failed: \(error.localizedDescription)")
        return
      }
    }
  }
}

extension LoginViewController: GIDSignInUIDelegate { }
