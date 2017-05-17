//
//  MenuItemCell.swift
//  Taasky
//
//  Created by Audrey M Tam on 18/03/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class MenuItemCell: UITableViewCell {
  
  @IBOutlet weak var menuItemImageView: UIImageView!
  
  func configureForMenuItem(_ menuItem: NSDictionary) {
    menuItemImageView.image = UIImage(named: menuItem["image"] as! String)
    backgroundColor = UIColor(colorArray: menuItem["colors"] as! NSArray)
  }
  
}
