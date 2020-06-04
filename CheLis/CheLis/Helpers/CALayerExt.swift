//
//  CALayerExt.swift
//  CheLis
//
//  Created by Quang Tran on 4/10/19.
//  Copyright © 2019 Quang Tran. All rights reserved.
//

import UIKit

extension CALayer {
  
  func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
    
    let border = CALayer()
    
    switch edge {
    case .top:
      border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
    case .bottom:
      border.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
    case .left:
      border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height)
    case .right:
      border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
    default:
      break
    }
    
    border.backgroundColor = color.cgColor;
    addSublayer(border)
  }
}
