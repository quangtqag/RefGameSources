//
//  ViewController.swift
//  CustomAlert
//
//  Created by Quang Tran on 11/28/16.
//  Copyright © 2016 Quang Tran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func showButtonDidTap(sender: AnyObject) {
    let confirmationAlertVC = ConfirmationAlertVC()
    confirmationAlertVC.alertTitle = "Does your video contain only 1 made dunk?"
    
    confirmationAlertVC.switchDidChangeStateCallback = { on in
      print("on = \(on)")
    }
    
    confirmationAlertVC.noCallback = {
      print("no button did tap")
    }
    
    confirmationAlertVC.yesCallback = {
      print("yes button did tap")
    }
    self.presentViewController(confirmationAlertVC, animated: true, completion: nil)
  }

}

