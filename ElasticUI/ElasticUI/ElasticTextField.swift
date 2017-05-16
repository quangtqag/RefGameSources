//
//  ElasticTextField.swift
//  ElasticUI
//
//  Created by Quang Tran on 5/10/17.
//  Copyright © 2017 Daniel Tavares. All rights reserved.
//

import UIKit

class ElasticTextField: UITextField {

  // 1
  var elasticView : ElasticView!
  
  // 2
  @IBInspectable var overshootAmount: CGFloat = 10 {
    didSet {
      elasticView.overshootAmount = overshootAmount
    }
  }
  
  // 3
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    setupView()
  }
  
  // 4
  func setupView() {
    // A
    clipsToBounds = false
    borderStyle = .none
    
    // B
    elasticView = ElasticView(frame: bounds)
    elasticView.backgroundColor = backgroundColor
    addSubview(elasticView)
    
    // C
    backgroundColor = UIColor.clear
    
    // D
    elasticView.isUserInteractionEnabled = false
  }
  
  // 5
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    elasticView.touchesBegan(touches, with: event)
  }
}
