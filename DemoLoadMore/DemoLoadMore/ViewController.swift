//
//  ViewController.swift
//  DemoLoadMore
//
//  Created by Quang Tran on 10/14/16.
//  Copyright © 2016 ABC Virtual Communications. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  var users = [String]()
  var loadingView = LoadingView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.tableFooterView = UIView()
    
    self.tableView.backgroundView = InfoBackgroundView(style: InfoBackgroundView.InfoStyle.loading)
    self.pullData()
  }
  
  @IBAction func segmentControlDidChange(_ sender: UISegmentedControl) {
    switch sender.selectedSegmentIndex {
    case 0:
      self.tableView.backgroundView = InfoBackgroundView(style: InfoBackgroundView.InfoStyle.loading)
      break
    case 1:
      self.tableView.backgroundView = InfoBackgroundView(style: InfoBackgroundView.InfoStyle.info, info: "No Internet Connection.")
      break
    case 2:
      self.tableView.backgroundView = InfoBackgroundView(
        style: InfoBackgroundView.InfoStyle.refresh,
        info: "No Internet Connection.",
        refreshTitle: "Retry") {
          print("Retry button did tap")
      }
      break
    default:
      break
    }
  }

  func pullData() {
    let delay = DispatchTime.now() + Double(Int64(UInt64(arc4random_uniform(4) + 1) * NSEC_PER_SEC)) / Double(NSEC_PER_SEC)
    let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
    queue.asyncAfter(deadline: delay) {
      var indexPaths = [IndexPath]()
      for _ in 1...10 {
        indexPaths.append(IndexPath(row: self.users.count, section: 0))
        self.users.append("User \(self.users.count + 1)")
      }
      DispatchQueue.main.async(execute: {
        self.tableView.insertRows(at: indexPaths, with: UITableViewRowAnimation.automatic)
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundView = nil
      })
    }
  }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return users.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
    if cell == nil {
      cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
    }
    cell!.textLabel!.text = self.users[(indexPath as NSIndexPath).row]
    return cell!
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if (indexPath as NSIndexPath).row == self.users.count - 1 {
      self.pullData()
      
      self.loadingView.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40)
      self.tableView.tableFooterView = self.loadingView
    }
  }
}

extension ViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if (scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.frame.size.height) {
      scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: scrollView.contentSize.height - scrollView.frame.size.height)
    }
  }
}








