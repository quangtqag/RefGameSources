//
//  ElasticView.swift
//  ElasticUI
//
//  Created by Quang Tran on 5/10/17.
//  Copyright © 2017 Daniel Tavares. All rights reserved.
//

import UIKit

class ElasticView: UIView {
  @IBInspectable var overshootAmount : CGFloat = 10

  private let topControlPointView = UIView()
  private let leftControlPointView = UIView()
  private let bottomControlPointView = UIView()
  private let rightControlPointView = UIView()
  
  private let elasticShape = CAShapeLayer()
  private lazy var displayLink : CADisplayLink = {
    let displayLink = CADisplayLink(target: self, selector: #selector(updateLoop))
    displayLink.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
    return displayLink
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupComponents()
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    setupComponents()
  }
  
  private func setupComponents() {
    elasticShape.fillColor = backgroundColor?.cgColor
    elasticShape.path = UIBezierPath(rect: self.bounds).cgPath
    layer.addSublayer(elasticShape)
    backgroundColor = UIColor.clear
    
    for controlPoint in [topControlPointView, leftControlPointView, bottomControlPointView, rightControlPointView] {
      addSubview(controlPoint)
      controlPoint.frame = CGRect(x: 0.0, y: 0.0, width: 5.0, height: 5.0)
      controlPoint.backgroundColor = UIColor.blue
    }
    
    positionControlPoints()

  }
  
  private func positionControlPoints(){
    topControlPointView.center = CGPoint(x: bounds.midX, y: 0.0)
    leftControlPointView.center = CGPoint(x: 0.0, y: bounds.midY)
    bottomControlPointView.center = CGPoint(x:bounds.midX, y: bounds.maxY)
    rightControlPointView.center = CGPoint(x: bounds.maxX, y: bounds.midY)
  }
  
  private func bezierPathForControlPoints()->CGPath {
    // 1
    let path = UIBezierPath()
    
    // 2
    let top = topControlPointView.layer.presentation()?.position
    let left = leftControlPointView.layer.presentation()?.position
    let bottom = bottomControlPointView.layer.presentation()?.position
    let right = rightControlPointView.layer.presentation()?.position
    
    let width = frame.size.width
    let height = frame.size.height
    
    // 3
    path.move(to: CGPoint(x: 0, y: 0))
    path.addQuadCurve(to: CGPoint(x: width, y: 0), controlPoint: top!)
    path.addQuadCurve(to: CGPoint(x: width, y: height), controlPoint:right!)
    path.addQuadCurve(to: CGPoint(x: 0, y: height), controlPoint:bottom!)
    path.addQuadCurve(to: CGPoint(x: 0, y: 0), controlPoint: left!)
    
    // 4
    return path.cgPath
  }
  
  func updateLoop() {
    elasticShape.path = bezierPathForControlPoints()
  }
  
  private func startUpdateLoop() {
    displayLink.isPaused = false
  }
  
  private func stopUpdateLoop() {
    displayLink.isPaused = true
  }
  
  func animateControlPoints() {
    //1
    let overshootAmount = self.overshootAmount
    // 2
    UIView.animate(
      withDuration: 0.25,
      delay: 0.0,
      usingSpringWithDamping: 0.9,
      initialSpringVelocity: 1.5,
      options: [],
      animations: {
        // 3
        self.topControlPointView.center.y -= overshootAmount
        self.leftControlPointView.center.x -= overshootAmount
        self.bottomControlPointView.center.y += overshootAmount
        self.rightControlPointView.center.x += overshootAmount },
      completion: { _ in
        // 4
        UIView.animate(
          withDuration: 5.45,
          delay: 0.0,
          usingSpringWithDamping: 0.15,
          initialSpringVelocity: 5.5,
          options: [],
          animations: {
            // 5
            self.positionControlPoints() },
          completion: { _ in
            // 6
            self.stopUpdateLoop()
        })
    })
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    startUpdateLoop()
    animateControlPoints()
  }
  
  override var backgroundColor: UIColor? {
    willSet {
      if let newValue = newValue {
        elasticShape.fillColor = newValue.cgColor
      }
    }
    didSet {
      super.backgroundColor = UIColor.clear
    }
  }
}
