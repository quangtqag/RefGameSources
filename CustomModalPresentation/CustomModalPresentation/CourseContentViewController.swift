//
//  CourseContentViewController.swift
//  RevealedView
//
//  Created by Quang Tran on 9/19/16.
//  Copyright © 2016 ABC Virtual Communications. All rights reserved.
//

import UIKit

class CourseContentViewController: UIViewController {
  
  var transitioner : RevealTransitioner
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
  
  init() {
    self.transitioner = RevealTransitioner()
    
    super.init(nibName: "CourseContentViewController", bundle: nil)
    
    self.modalPresentationStyle = .Custom
    self.transitioningDelegate = self.transitioner
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @IBAction func dismissButtonDidTap(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
}
