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
  
  override func viewDidLoad() {
    super.viewDidLoad()
 
  }

  @IBAction func didTapStartButtton(sender: AnyObject) {
    myLoadingIndicator.startAnimating()
    
  }
  
  @IBAction func didTapStopButton(sender: AnyObject) {
    myLoadingIndicator.stopAnimating()
  }
}
