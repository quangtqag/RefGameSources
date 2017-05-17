//
//  CustomNavigationController.swift
//  RW - Paper
//
//  Created by Eric Cerney on 5/14/15.
//  Copyright (c) 2015 -. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //1
    delegate = self
  }
  
  //2
  func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    if operation == .push {
      if let vc = fromVC as? BooksViewController {
        return vc.animationControllerForPresentController(toVC)
      }
    }
    
    if operation == .pop {
      if let vc = toVC as? BooksViewController {
        return vc.animationControllerForDismissController(vc)
      }
    }
    
    return nil
  }
  
  func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    if let animationController = animationController as? BookOpeningTransition {
      return animationController.interactionController
    }
    return nil
  }
}
