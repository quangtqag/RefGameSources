//
//  LoadingView.swift
//  DemoLoadMore
//
//  Created by Quang on 10/15/16.
//  Copyright © 2016 ABC Virtual Communications. All rights reserved.
//

import UIKit

class LoadingView: UIView {
  
  var activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.activityIndicatorView.startAnimating()
    self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(self.activityIndicatorView)
    self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
