//
//  UIImageViewExt.swift
//  CheLis
//
//  Created by Quang Tran on 4/9/19.
//  Copyright © 2019 Quang Tran. All rights reserved.
//

import UIKit

extension UIImageView {
  override open func awakeFromNib() {
    super.awakeFromNib()
    tintColorDidChange()
  }
}
