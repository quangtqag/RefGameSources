//
//  MyLoadingIndicator.swift
//  CustomLoadingIndicator
//
//  Created by Quang on 6/11/16.
//  Copyright © 2016 Quang. All rights reserved.
//

import UIKit

@IBDesignable
class MyLoadingIndicator: UIView {
  
  var isAnimating = false

  override init(frame: CGRect) {
    super.init(frame: frame)
    myInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    myInit()
  }
  
  fileprivate func myInit() {
    self.backgroundColor = UIColor.clear
  }
  
  func startAnimating() {
    let animateZRotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
    animateZRotation.toValue = NSNumber(value: 2 * Float(Double.pi) as Float)
    animateZRotation.duration = 1
    animateZRotation.repeatCount = Float.infinity
    
    self.layer.add(animateZRotation, forKey: "rotate")
    self.isAnimating = true
  }
  
  func stopAnimating() {
    self.layer.removeAllAnimations()
    self.isAnimating = false
  }
  
  override func draw(_ layer: CALayer, in ctx: CGContext) {
    let lineWidth: CGFloat = 5
    // Variables for create gradient
    let startColor = UIColor(white: 1, alpha: 0).cgColor
    let endColor = UIColor.green.cgColor
    let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
    let colors: [CGColor] = [startColor, endColor]
    let locations: [CGFloat] = [0.0, 1.0]
    let gradient: CGGradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations)!
    let startPoint = CGPoint(x: self.bounds.size.width - lineWidth/2, y: self.bounds.size.height/2)
    let endPoint = CGPoint(x: 0, y: self.bounds.height/2)
    let centerPoint = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
    
    // Stroke arc with gradient
    let path: CGMutablePath = CGMutablePath()
    path.addArc(center: centerPoint, radius: self.bounds.size.width/2 - lineWidth/2, startAngle: 0, endAngle: CGFloat(Double.pi), clockwise: false)
    ctx.addPath(path)
    ctx.setLineWidth(lineWidth)
    ctx.setLineCap(CGLineCap.round)
    ctx.replacePathWithStrokedPath()
    ctx.clip()
    ctx.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [CGGradientDrawingOptions.drawsBeforeStartLocation, CGGradientDrawingOptions.drawsAfterEndLocation])
  }
 
  // Without this function draw(_ layer: CALayer, in ctx: CGContext) will not run
  override func draw(_ rect: CGRect) {
    super.draw(rect)
  }
}
