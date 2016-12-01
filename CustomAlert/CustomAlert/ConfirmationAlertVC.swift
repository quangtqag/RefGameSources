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
  var switchDidChangeStateCallback: ((on: Bool)->())!
  
  // Internal
  @IBOutlet weak var chromeView: UIView!
  @IBOutlet weak var modalView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var dontShowAgainLabel: UILabel!
  @IBOutlet weak var dontShowAgainSwitch: UISwitch!
  @IBOutlet weak var noButton: UIButton!
  @IBOutlet weak var yesButton: UIButton!
  
  let animationTimeInterval: NSTimeInterval = 0.25
  let scaleRatio: CGFloat = 0.7
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.configUI()
    self.populateData()
  }
  
  private func populateData() {
    self.titleLabel.text = self.alertTitle
  }
  
  private func configUI() {
    self.chromeView.alpha = 0
    
    self.modalView.layer.cornerRadius = 5
    self.modalView.layer.masksToBounds = true
    self.modalView.alpha = 0
    self.modalView.transform = CGAffineTransformMakeScale(self.scaleRatio, self.scaleRatio)
    
    self.noButton.layer.borderColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.7).CGColor
    self.noButton.layer.borderWidth = 0.5
    
    self.yesButton.layer.borderColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.7).CGColor
    self.yesButton.layer.borderWidth = 0.5
  }
  
  override func viewDidAppear(animated: Bool) {
    self.animateShowModalWithCompletionBlock(nil)
  }
  
  private func animateShowModalWithCompletionBlock(completionBlock: (()->())?) {
    UIView.animateWithDuration(animationTimeInterval, animations: {
      self.chromeView.alpha = 1
      self.modalView.alpha = 1
      self.modalView.transform = CGAffineTransformMakeScale(1.0, 1.0)
    }) { completed in
      completionBlock?()
    }
  }
  
  private func animateHideModalWithCompletionBlock(completionBlock: (()->())?) {
    UIView.animateWithDuration(animationTimeInterval, animations: {
      self.chromeView.alpha = 0
      self.modalView.alpha = 0
      self.modalView.transform = CGAffineTransformMakeScale(self.scaleRatio, self.scaleRatio)
    }) { (completed) in
      self.dismissViewControllerAnimated(false, completion: nil)
      completionBlock?()
    }
  }
  
  @IBAction func switchDidChangeState(sender: UISwitch) {
    self.switchDidChangeStateCallback(on: sender.on)
  }
  
  @IBAction func noButtonDidTap(sender: AnyObject) {
    self.animateHideModalWithCompletionBlock { 
      self.noCallback?()
    }
  }
  
  @IBAction func yesButtonDidTap(sender: AnyObject) {
    self.animateHideModalWithCompletionBlock {
      self.yesCallback()
    }
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    
    self.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
    self.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
