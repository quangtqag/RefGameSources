//
//  FlickrPhotoCell.swift
//  FlickrSearch
//
//  Created by Richard Turton on 30/06/2016.
//  Copyright © 2016 Richard Turton. All rights reserved.
//

import UIKit

class FlickrPhotoCell: UICollectionViewCell {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  override var isSelected: Bool {
    didSet {
      imageView.layer.borderWidth = isSelected ? 10 : 0
    }
  }
  
  // MARK: - View Life Cycle
  override func awakeFromNib() {
    super.awakeFromNib()
    imageView.layer.borderColor = themeColor.cgColor
    isSelected = false
  }
}
