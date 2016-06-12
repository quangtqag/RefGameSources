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

  override init(frame: CGRect) {
    super.init(frame: frame)
    myInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    myInit()
  }
  
  private func myInit() {
    self.backgroundColor = UIColor.clearColor()
  }
  
  func startAnimating() {
    let animateZRotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
    animateZRotation.toValue = NSNumber(float: 2 * Float(M_PI))
    animateZRotation.duration = 1
    animateZRotation.repeatCount = Float.infinity
    
    self.layer.addAnimation(animateZRotation, forKey: "rotate")
  }
  
  func stopAnimating() {
    self.layer.removeAllAnimations()
  }
  
  override func drawLayer(layer: CALayer, inContext context: CGContext) {
    let lineWidth: CGFloat = 5
    // Variables for create gradient
    let startColor = UIColor(white: 1, alpha: 0).CGColor
    let endColor = UIColor.greenColor().CGColor
    let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()!
    let colors: [CGColor] = [startColor, endColor]
    let locations: [CGFloat] = [0.0, 1.0]
    let gradient: CGGradient = CGGradientCreateWithColors(colorSpace, colors, locations)!
    let startPoint = CGPointMake(self.bounds.size.width - lineWidth/2, self.bounds.size.height/2)
    let endPoint = CGPointMake(0, self.bounds.height/2)
    let centerPoint = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)
    
    // Stroke arc with gradient
    let arc: CGMutablePath = CGPathCreateMutable()
    CGPathAddArc(arc, nil, centerPoint.x, centerPoint.y, self.bounds.size.width/2 - lineWidth/2, 0, CGFloat(M_PI), false)
    CGContextAddPath(context, arc)
    CGContextSetLineWidth(context, lineWidth)
    CGContextSetLineCap(context, CGLineCap.Round)
    CGContextReplacePathWithStrokedPath(context)
    CGContextClip(context)
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, [CGGradientDrawingOptions.DrawsBeforeStartLocation, CGGradientDrawingOptions.DrawsAfterEndLocation])
  }
  
  override func drawRect(rect: CGRect) {
    
  }
 
}
