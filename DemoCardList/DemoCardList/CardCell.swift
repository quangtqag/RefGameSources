//
//  CardCellTableViewCell.swift
//  DemoCardList
//
//  Created by Quang on 10/15/16.
//  Copyright © 2016 Quang Tran. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell {
  
  @IBOutlet weak var cardView: UIView!
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
  override func layoutSubviews() {
    self.cardView.layer.masksToBounds = false
    self.cardView.layer.cornerRadius = 3
    self.cardView.layer.shadowOffset = CGSize(width: 0.5, height: 1)
    self.cardView.layer.shadowRadius = 2
    self.cardView.layer.shadowOpacity = 0.3
  }
  
  
}
