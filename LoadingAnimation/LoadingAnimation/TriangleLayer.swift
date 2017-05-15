//
//  TriangleLayer.swift
//  SBLoader
//
//  Created by Satraj Bambra on 2015-03-19.
//  Copyright (c) 2015 Satraj Bambra. All rights reserved.
//

import UIKit

class TriangleLayer: CAShapeLayer {
  
  let innerPadding: CGFloat = 30.0
  
  override init() {
    super.init()
    fillColor = Colors.red.cgColor
    strokeColor = Colors.red.cgColor
    lineWidth = 7.0
    lineCap = kCALineCapRound
    lineJoin = kCALineJoinRound
    path = trianglePathSmall.cgPath
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  var trianglePathSmall: UIBezierPath {
    let trianglePath = UIBezierPath()
    trianglePath.move(to: CGPoint(x: 5.0 + innerPadding, y: 95.0))
    trianglePath.addLine(to: CGPoint(x: 50.0, y: 12.5 + innerPadding))
    trianglePath.addLine(to: CGPoint(x: 95.0 - innerPadding, y: 95.0))
    trianglePath.close()
    return trianglePath
  }
  
  var trianglePathLeftExtension: UIBezierPath {
    let trianglePath = UIBezierPath()
    trianglePath.move(to: CGPoint(x: 5.0, y: 95.0))
    trianglePath.addLine(to: CGPoint(x: 50.0, y: 12.5 + innerPadding))
    trianglePath.addLine(to: CGPoint(x: 95.0 - innerPadding, y: 95.0))
    trianglePath.close()
    return trianglePath
  }
  
  var trianglePathRightExtension: UIBezierPath {
    let trianglePath = UIBezierPath()
    trianglePath.move(to: CGPoint(x: 5.0, y: 95.0))
    trianglePath.addLine(to: CGPoint(x: 50.0, y: 12.5 + innerPadding))
    trianglePath.addLine(to: CGPoint(x: 95.0, y: 95.0))
    trianglePath.close()
    return trianglePath
  }
  
  var trianglePathTopExtension: UIBezierPath {
    let trianglePath = UIBezierPath()
    trianglePath.move(to: CGPoint(x: 5.0, y: 95.0))
    trianglePath.addLine(to: CGPoint(x: 50.0, y: 12.5))
    trianglePath.addLine(to: CGPoint(x: 95.0, y: 95.0))
    trianglePath.close()
    return trianglePath
  }
  
  func animate() {
    let triangleAnimationLeft: CABasicAnimation = CABasicAnimation(keyPath: "path")
    triangleAnimationLeft.fromValue = trianglePathSmall.cgPath
    triangleAnimationLeft.toValue = trianglePathLeftExtension.cgPath
    triangleAnimationLeft.beginTime = 0.0
    triangleAnimationLeft.duration = 0.3
    
    let triangleAnimationRight: CABasicAnimation = CABasicAnimation(keyPath: "path")
    triangleAnimationRight.fromValue = trianglePathLeftExtension.cgPath
    triangleAnimationRight.toValue = trianglePathRightExtension.cgPath
    triangleAnimationRight.beginTime = triangleAnimationLeft.beginTime + triangleAnimationLeft.duration
    triangleAnimationRight.duration = 0.25
    
    let triangleAnimationTop: CABasicAnimation = CABasicAnimation(keyPath: "path")
    triangleAnimationTop.fromValue = trianglePathRightExtension.cgPath
    triangleAnimationTop.toValue = trianglePathTopExtension.cgPath
    triangleAnimationTop.beginTime = triangleAnimationRight.beginTime + triangleAnimationRight.duration
    triangleAnimationTop.duration = 0.20
    
    let triangleAnimationGroup: CAAnimationGroup = CAAnimationGroup()
    triangleAnimationGroup.animations = [triangleAnimationLeft, triangleAnimationRight,
                                         triangleAnimationTop]
    triangleAnimationGroup.duration = triangleAnimationTop.beginTime + triangleAnimationTop.duration
    triangleAnimationGroup.fillMode = kCAFillModeForwards
    triangleAnimationGroup.isRemovedOnCompletion = false
    add(triangleAnimationGroup, forKey: nil)
  }
}
