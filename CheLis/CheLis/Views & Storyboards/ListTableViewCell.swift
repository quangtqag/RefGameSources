//
//  ListTableViewCell.swift
//  CheLis
//
//  Created by Quang Tran on 4/7/19.
//  Copyright © 2019 Quang Tran. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
  
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var statisticLabel: UILabel!
  @IBOutlet var cardView: UIView!
  
  var list: List! {
    didSet {
      nameLabel.text = list.name
      var statisticMessage = "Tap to add items."
      if list.unfinishedItemsCount > 0 {
        statisticMessage = "\(list.unfinishedItemsCount) remaining item\(list.unfinishedItemsCount > 1 ? "s" : "") to finish."
      }
      else if list.finishedItemsCount > 0 {
        statisticMessage = "All items have been finished."
      }
      statisticLabel.text = statisticMessage
      cardView.backgroundColor = ColorManager.colors[list.colorIndex]
    }
  }
  
  override var isHighlighted: Bool {
    didSet {
      cardView.alpha = isHighlighted ? 0.5 : 1.0
    }
  }
}
