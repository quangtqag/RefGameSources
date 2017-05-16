//
//  HolderView.swift
//  SBLoader
//
//  Created by Satraj Bambra on 2015-03-17.
//  Copyright (c) 2015 Satraj Bambra. All rights reserved.
//

import UIKit

protocol HolderViewDelegate:class {
  func animateLabel()
}

class HolderView: UIView {

  let ovalLayer = OvalLayer()
  let triangleLayer = TriangleLayer()
  let redRectangleLayer = RectangleLayer()
  let blueRectangleLayer = RectangleLayer()
  let arcLayer = ArcLayer()

  var parentFrame :CGRect = CGRect.zero
  weak var delegate:HolderViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = Colors.clear
  }
  
  required init(coder: NSCoder) {
    super.init(coder: coder)!
  }
  
  func addOval() {
    layer.addSublayer(ovalLayer)
    ovalLayer.expand()
    Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(HolderView.wobbleOval), userInfo: nil, repeats: false)
  }

  func wobbleOval() {
    // 1
    layer.addSublayer(triangleLayer) // Add this line
    ovalLayer.wobble()
    
    // 2
    // Add the code below
    Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(HolderView.drawAnimatedTriangle), userInfo: nil, repeats: false)
  }
  
  func drawAnimatedTriangle() {
    triangleLayer.animate()
    
    Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(HolderView.spinAndTransform), userInfo: nil, repeats: false)

  }
  
  func spinAndTransform() {
    // 1
    layer.anchorPoint = CGPoint(x: 0.5, y: 0.6)
    
    // 2
    let rotationAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
    rotationAnimation.toValue = CGFloat(Double.pi * 2.0)
    rotationAnimation.duration = 0.45
    rotationAnimation.isRemovedOnCompletion = true
    layer.add(rotationAnimation, forKey: nil)
    
    // 3
    ovalLayer.contract()
    
    Timer.scheduledTimer(timeInterval: 0.45, target: self, selector: #selector(HolderView.drawRedAnimatedRectangle), userInfo: nil, repeats: false)
    Timer.scheduledTimer(timeInterval: 0.65, target: self, selector: #selector(HolderView.drawBlueAnimatedRectangle), userInfo: nil, repeats: false)
  }
  
  func drawRedAnimatedRectangle() {
    layer.addSublayer(redRectangleLayer)
    redRectangleLayer.animateStrokeWithColor(color: Colors.red)
  }
  
  func drawBlueAnimatedRectangle() {
    layer.addSublayer(blueRectangleLayer)
    blueRectangleLayer.animateStrokeWithColor(color: Colors.blue)
    
    Timer.scheduledTimer(timeInterval: 0.40, target: self, selector: #selector(HolderView.drawArc), userInfo: nil, repeats: false)
  }

  func drawArc() {
    layer.addSublayer(arcLayer)
    arcLayer.animate()
    
    Timer.scheduledTimer(timeInterval: 0.90, target: self, selector: #selector(HolderView.expandView), userInfo: nil, repeats: false)
  }
  
  func expandView() {
    // 1
    backgroundColor = Colors.blue
    
    // 2
    frame = CGRect(x: frame.origin.x - blueRectangleLayer.lineWidth,
                   y: frame.origin.y - blueRectangleLayer.lineWidth,
                   width: frame.size.width + blueRectangleLayer.lineWidth * 2,
                   height: frame.size.height + blueRectangleLayer.lineWidth * 2)
    
    // 3
    layer.sublayers = nil
    
    // 4
    UIView.animate(
      withDuration: 0.3,
      delay: 0.0,
      options: [UIViewAnimationOptions.curveEaseInOut],
      animations: {
        self.frame = self.parentFrame
    }, completion: { finished in
      self.addLabel()
    })
  }
  
  func addLabel() {
    delegate?.animateLabel()
  }
}
