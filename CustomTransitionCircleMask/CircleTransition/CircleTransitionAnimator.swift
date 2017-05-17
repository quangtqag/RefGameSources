//
//  CircleTransitionAnimator.swift
//  CircleTransition
//
//  Created by Rounak Jain on 23/10/14.
//  Copyright (c) 2014 Rounak Jain. All rights reserved.
//

import UIKit

class CircleTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  
  weak var transitionContext: UIViewControllerContextTransitioning?
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.5;
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    self.transitionContext = transitionContext
    
    let containerView = transitionContext.containerView
    let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! ViewController
    let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! ViewController
    let button: UIButton = fromViewController.button
    
    containerView.addSubview(toViewController.view)
    
    let circleMaskPathInitial = UIBezierPath(ovalIn: button.frame)
    let extremePoint = CGPoint(x: button.center.x - 0, y: button.center.y - toViewController.view.bounds.height)
    let radius = sqrt((extremePoint.x * extremePoint.x) + (extremePoint.y * extremePoint.y))
    let circleMaskPathFinal = UIBezierPath(ovalIn: button.frame.insetBy(dx: -radius, dy: -radius))
    
    let maskLayer = CAShapeLayer()
    maskLayer.path = circleMaskPathFinal.cgPath
    toViewController.view.layer.mask = maskLayer
    
    CATransaction.begin()
    let maskLayerAnimation = CABasicAnimation(keyPath: "path")
    maskLayerAnimation.fromValue = circleMaskPathInitial.cgPath
    maskLayerAnimation.toValue = circleMaskPathFinal.cgPath
    maskLayerAnimation.duration = self.transitionDuration(using: transitionContext)
    maskLayerAnimation.delegate = self as? CAAnimationDelegate
    CATransaction.setCompletionBlock { 
      self.transitionContext?.completeTransition(!self.transitionContext!.transitionWasCancelled)
      self.transitionContext?.viewController(forKey: UITransitionContextViewControllerKey.from)?.view.layer.mask = nil
    }
    maskLayer.add(maskLayerAnimation, forKey: "path")
    CATransaction.commit()
  }
}
