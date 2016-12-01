//
//  ViewController.swift
//  GetLaidOutCellHeight
//
//  Created by Quang Tran on 10/17/16.
//  Copyright © 2016 ABC Virtual Communications. All rights reserved.
//

import UIKit
import LoremIpsum

class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  var prototypeCell: UITableViewCell?
  var messages = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.delegate = self
    self.tableView.dataSource = self
    
    for _ in 0...9 {
      self.messages.append(LoremIpsum.sentences(withNumber: Int(arc4random_uniform(3) + 1)))
    }
  }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
    
    let label = cell!.contentView.viewWithTag(1) as! UILabel
    label.numberOfLines = 0
    label.text = self.messages[(indexPath as NSIndexPath).row]
    
    return cell!
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    if prototypeCell == nil { prototypeCell = tableView.dequeueReusableCell(withIdentifier: "cell") }
    
    let label = prototypeCell!.contentView.viewWithTag(1) as! UILabel
    label.text = self.messages[(indexPath as NSIndexPath).row]
    label.numberOfLines = 0
    label.preferredMaxLayoutWidth = tableView.bounds.width - 16
    
    prototypeCell!.layoutIfNeeded()
    let size = prototypeCell!.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
    
    return size.height + 1 // Plus 1 for separator line
  }

}
