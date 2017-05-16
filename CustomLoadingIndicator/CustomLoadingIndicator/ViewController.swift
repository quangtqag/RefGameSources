//
//  ViewController.swift
//  CustomLoadingIndicator
//
//  Created by Quang on 6/11/16.
//  Copyright © 2016 Quang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var myLoadingIndicator: MyLoadingIndicator!
  @IBOutlet weak var startBtn: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
 
  }

  @IBAction func didTapStartButtton(_ sender: AnyObject) {
    if self.myLoadingIndicator.isAnimating == true {
      self.myLoadingIndicator.stopAnimating()
      self.startBtn.setTitle("Start", for: UIControlState.normal)
    }
    else {
      self.myLoadingIndicator.startAnimating()
      self.startBtn.setTitle("Stop", for: UIControlState.normal)
    }
  }
}
