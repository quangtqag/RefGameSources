//
//  ContainerViewController.swift
//  Taasky
//
//  Created by Audrey M Tam on 18/03/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController, UIScrollViewDelegate {
  @IBOutlet weak var menuContainerView: UIView!
  @IBOutlet weak var scrollView: UIScrollView!
  
  fileprivate var detailViewController: DetailViewController?
    
  var menuItem: NSDictionary? {
    didSet {
      hideOrShowMenu(false, animated: true)
      if let detailViewController = detailViewController {
        detailViewController.menuItem = menuItem
      }
    }
  }
  
  var showingMenu = false
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    menuContainerView.layer.anchorPoint = CGPoint(x: 1.0, y: 0.5)
    hideOrShowMenu(showingMenu, animated: false)
  }
  
  // MARK: ContainerViewController
  func hideOrShowMenu(_ show: Bool, animated: Bool) {
    let xOffset = menuContainerView.bounds.width
    scrollView.setContentOffset(show ? CGPoint.zero : CGPoint(x: xOffset, y: 0), animated: animated)
    showingMenu = show
  }
  
  // MARK: - UIScrollViewDelegate
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let multiplier = 1.0 / menuContainerView.bounds.width
    let offset = scrollView.contentOffset.x * multiplier
    let fraction = 1.0 - offset
    //    println("didScroll offset \(offset)")
    menuContainerView.layer.transform = transformForFraction(fraction)
    menuContainerView.alpha = fraction
    
    if let detailViewController = detailViewController {
      if let rotatingView = detailViewController.hamburgerView {
        rotatingView.rotate(fraction)
      }
    }
    
    /*
    Fix for the UIScrollView paging-related issue mentioned here:
    http://stackoverflow.com/questions/4480512/uiscrollview-single-tap-scrolls-it-to-top
    */
    scrollView.isPagingEnabled = scrollView.contentOffset.x < (scrollView.contentSize.width - scrollView.frame.width)
    
    let menuOffset = menuContainerView.bounds.width
    showingMenu = !CGPoint(x: menuOffset, y: 0).equalTo(scrollView.contentOffset)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "DetailViewSegue" {
      let navigationController = segue.destination as! UINavigationController
      detailViewController = navigationController.topViewController as? DetailViewController
    }
  }
    
  // MARK: - Private
  
  func transformForFraction(_ fraction:CGFloat) -> CATransform3D {
    var identity = CATransform3DIdentity
    identity.m34 = -1.0 / 1000.0;
    let angle = Double(1.0 - fraction) * -M_PI_2
    let xOffset = menuContainerView.bounds.width * 0.5
    let rotateTransform = CATransform3DRotate(identity, CGFloat(angle), 0.0, 1.0, 0.0)
    let translateTransform = CATransform3DMakeTranslation(xOffset, 0.0, 0.0)
    return CATransform3DConcat(rotateTransform, translateTransform)
  }


}
