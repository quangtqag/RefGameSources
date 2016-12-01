//
//  Utils.swift
//  TransparentNaviBar
//
//  Created by Quang Tran on 12/1/16.
//  Copyright © 2016 Quang Tran. All rights reserved.
//

import UIKit

class Utils: NSObject {
  class func setStatusBarBackgroundColor(color: UIColor) {
    
    guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
    
    statusBar.backgroundColor = color
  }
}
