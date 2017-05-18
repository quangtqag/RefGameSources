//
//  InfoBackgroundView.swift
//  DemoLoadMore
//
//  Created by Quang on 10/15/16.
//  Copyright © 2016 ABC Virtual Communications. All rights reserved.
//

import UIKit

class InfoBackgroundView: UIView {
  
  var style = InfoStyle.loading
  var info: String?
  var refreshTitle: String?
  var refreshBlock: (()->())?
  
  enum InfoStyle {
    case loading
    case info
    case refresh
  }
  
  // Internal
  fileprivate var infoLB: UILabel?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  convenience init(style: InfoStyle, info: String? = nil, refreshTitle: String? = nil, refreshBlock: (()->())? = nil) {
    self.init(frame: CGRect.zero)
    
//    self.backgroundColor = UIColor.greenColor()
    self.style = style
    self.info = info
    self.refreshTitle = refreshTitle
    self.refreshBlock = refreshBlock
    self.initializeUI()
  }
  
  fileprivate func initializeUI() {
    switch style {
    case .loading:
      self.setupLoadingUI()
      break
    case .info:
      self.setupInfoUI()
      break
    case .refresh:
      self.setupRefreshUI()
      break
    }
  }
  
  fileprivate func setupLoadingUI() {
    let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    activityIndicatorView.startAnimating()
    activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(activityIndicatorView)
    activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
  }
  
  fileprivate func setupInfoUI() {
    self.addInfoLabel()
  }
  
  fileprivate func addInfoLabel() {
    let infoLB = UILabel()
    infoLB.textAlignment = NSTextAlignment.center
    infoLB.font = UIFont.systemFont(ofSize: 20)
    infoLB.text = self.info
    infoLB.textColor = UIColor.darkGray
    infoLB.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(infoLB)
    infoLB.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    infoLB.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    infoLB.numberOfLines = 0
    infoLB.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
    infoLB.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
    
    self.infoLB = infoLB
  }
  
  fileprivate func addRefreshButton() {
    let refreshBT = UIButton(type: UIButtonType.system)
    refreshBT.setTitleColor(UIColor.darkGray, for: UIControlState())
    refreshBT.setTitle(self.refreshTitle, for: UIControlState())
    refreshBT.addTarget(self, action: #selector(refreshButtonDidTap), for: UIControlEvents.touchUpInside)
    refreshBT.translatesAutoresizingMaskIntoConstraints = false
    refreshBT.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8)
    self.addSubview(refreshBT)
    refreshBT.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    refreshBT.topAnchor.constraint(equalTo: (self.infoLB?.bottomAnchor)!, constant: 20).isActive = true
    refreshBT.layer.borderColor = UIColor.darkGray.cgColor
    refreshBT.layer.borderWidth = 1
    refreshBT.layer.cornerRadius = 5
    refreshBT.layer.masksToBounds = true
  }
  
  @objc fileprivate func refreshButtonDidTap() {
    self.refreshBlock?()
  }
  
  fileprivate func setupRefreshUI() {
    self.addInfoLabel()
    self.addRefreshButton()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
