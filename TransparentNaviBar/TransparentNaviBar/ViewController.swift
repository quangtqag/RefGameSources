//
//  ViewController.swift
//  TransparentNaviBar
//
//  Created by Quang Tran on 11/29/16.
//  Copyright © 2016 Quang Tran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var imageViewWidthConstraint: NSLayoutConstraint!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.automaticallyAdjustsScrollViewInsets = false
    self.scrollView.delegate = self
  }

  override func viewDidLayoutSubviews() {
    self.imageViewWidthConstraint.constant = self.scrollView.frame.size.width
  }
}

extension ViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
//    print("content offset = \(scrollView.contentOffset)")
    
    self.navigationController?.navigationBar.backgroundColor = UIColor(white: 1, alpha: scrollView.contentOffset.y / 100)
    Utils.setStatusBarBackgroundColor(color: UIColor(white: 1, alpha: scrollView.contentOffset.y / 100))
  }
}
