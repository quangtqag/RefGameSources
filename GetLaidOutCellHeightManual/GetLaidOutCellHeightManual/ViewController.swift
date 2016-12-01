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
  
  var messages = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.delegate = self
    self.tableView.dataSource = self
    
    for _ in 0...19 {
      self.messages.append(LoremIpsum.sentences(withNumber: Int(arc4random_uniform(3) + 1)))
    }
  }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 20
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
    
    let label = cell!.contentView.viewWithTag(1) as! UILabel
    label.numberOfLines = 0
    label.text = self.messages[(indexPath as NSIndexPath).row]
    
    return cell!
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    let msg = self.messages[(indexPath as NSIndexPath).row]
    let width = tableView.bounds.width
    let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 17)]
    let msgHeight = (msg as NSString).boundingRect(
      with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
      options: NSStringDrawingOptions.usesLineFragmentOrigin,
      attributes: attributes,
      context: nil).height
    
    let height = 114 - 21 + msgHeight
    return height
  }

}
