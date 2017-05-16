//
//  ConfirmationAlertVC.swift
//  CustomAlert
//
//  Created by Quang Tran on 11/28/16.
//  Copyright © 2016 Quang Tran. All rights reserved.
//

import UIKit

class ConfirmationAlertVC: UIViewController {
  
  // Input
  var alertTitle: String!
  var noCallback: (()->())?
  var yesCallback: (()->())!
  var switchDidChangeStateCallback: ((_ on: Bool)->())!
  
  // Internal
  @IBOutlet weak var modalView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var dontShowAgainLabel: UILabel!
  @IBOutlet weak var dontShowAgainSwitch: UISwitch!
  @IBOutlet weak var noButton: UIButton!
  @IBOutlet weak var yesButton: UIButton!
  
  let animationTimeInterval: TimeInterval = 0.25
  let scaleRatio: CGFloat = 0.7
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.configUI()
    self.populateData()
  }
  
  fileprivate func populateData() {
    self.titleLabel.text = self.alertTitle
  }
  
  fileprivate func configUI() {
    self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    self.view.alpha = 0
    
    self.modalView.layer.cornerRadius = 5
    self.modalView.layer.masksToBounds = true
    self.modalView.alpha = 0
    self.modalView.transform = CGAffineTransform(scaleX: self.scaleRatio, y: self.scaleRatio)
    
    self.noButton.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
    self.noButton.layer.borderWidth = 0.5
    
    self.yesButton.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
    self.yesButton.layer.borderWidth = 0.5
  }
  
  override func viewDidAppear(_ animated: Bool) {
    self.animateShowModalWithCompletionBlock(nil)
  }
  
  fileprivate func animateShowModalWithCompletionBlock(_ completionBlock: (()->())?) {
    UIView.animate(withDuration: animationTimeInterval, animations: {
      self.view.alpha = 1
      self.modalView.alpha = 1
      self.modalView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
    }, completion: { completed in
      completionBlock?()
    }) 
  }
  
  fileprivate func animateHideModalWithCompletionBlock(_ completionBlock: (()->())?) {
    UIView.animate(withDuration: animationTimeInterval, animations: {
      self.view.alpha = 0
      self.modalView.alpha = 0
      self.modalView.transform = CGAffineTransform(scaleX: self.scaleRatio, y: self.scaleRatio)
    }, completion: { (completed) in
      completionBlock?()
    }) 
  }
  
  @IBAction func switchDidChangeState(_ sender: UISwitch) {
    self.switchDidChangeStateCallback(sender.isOn)
  }
  
  @IBAction func noButtonDidTap(_ sender: AnyObject) {
    self.animateHideModalWithCompletionBlock { 
      self.noCallback?()
      self.dismiss(animated: false, completion: nil)
    }
  }
  
  @IBAction func yesButtonDidTap(_ sender: AnyObject) {
    self.animateHideModalWithCompletionBlock {
      self.yesCallback()
      self.dismiss(animated: false, completion: nil)
    }
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    
    self.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
    self.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
