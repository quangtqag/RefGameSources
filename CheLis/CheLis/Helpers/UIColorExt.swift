//
//  UIColorExt.swift
//  CheLis
//
//  Created by Quang Tran on 4/9/19.
//  Copyright © 2019 Quang Tran. All rights reserved.
//

import UIKit

extension UIColor {
  func interpolateTo(_ end: UIColor, fraction: CGFloat) -> UIColor {
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    self.getRed(&red, green: &green, blue: &blue, alpha: nil)
    
    var finalRed: CGFloat = 0
    var finalGreen: CGFloat = 0
    var finalBlue: CGFloat = 0
    end.getRed(&finalRed, green: &finalGreen, blue: &finalBlue, alpha: nil)
    
    let newRed   = (1.0 - fraction) * red   + fraction * finalRed;
    let newGreen = (1.0 - fraction) * green + fraction * finalGreen;
    let newBlue  = (1.0 - fraction) * blue  + fraction * finalBlue;
    let newColor = UIColor(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    
    return newColor
  }
}
