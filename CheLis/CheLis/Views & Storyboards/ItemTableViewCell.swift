//
//  ListTableViewCell.swift
//  CheLis
//
//  Created by Quang Tran on 4/7/19.
//  Copyright © 2019 Quang Tran. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
  
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var checkmarkImageView: UIImageView!
  @IBOutlet var cardView: UIView!
  
  var item: Item! {
    didSet {
      nameLabel.text = item.name
      nameLabel.textColor = item.finished ? .lightGray : .white
      checkmarkImageView.isHidden = !item.finished
      cardView.backgroundColor = item.finished
        ? ColorManager.finishedColor
        : ColorManager.colors.first
    }
  }
  
  override var isHighlighted: Bool {
    didSet {
      cardView.alpha = isHighlighted ? 0.5 : 1.0
    }
  }
}
