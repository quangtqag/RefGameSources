//
//  ColorButton.swift
//  FoPi
//
//  Created by Quang Tran on 3/16/19.
//  Copyright © 2019 Quang Tran. All rights reserved.
//

import UIKit

class ColorButton: UIButton {
  var color = UIColor.clear
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    color = backgroundColor!
    self.backgroundColor = .clear
  }
  
  override func draw(_ rect: CGRect) {
    guard let context = UIGraphicsGetCurrentContext() else {
      return
    }
    
    context.setFillColor(color.cgColor)
    context.addEllipse(in: rect)
    context.fillPath()
    
    if state == .selected {
      context.setStrokeColor(UIColor.white.cgColor)
      let margin: CGFloat = 16 * rect.size.width / 100.0
      context.setLineWidth(6 * rect.size.width / 100.0)
      context.addEllipse(in: rect.insetBy(dx: margin, dy: margin))
      context.strokePath()
    }
  }
}
