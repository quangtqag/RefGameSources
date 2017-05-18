//
//  ViewController.swift
//  RevealedView
//
//  Created by Quang Tran on 9/19/16.
//  Copyright © 2016 ABC Virtual Communications. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  @IBAction func showButtonDidTap(_ sender: AnyObject) {
    let courseContentVC = CourseContentViewController()
    self.present(courseContentVC, animated: true, completion: nil)
  }

}

