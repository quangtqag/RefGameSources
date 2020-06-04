//
//  TutorialViewController.swift
//  CheLis
//
//  Created by Quang Tran on 4/9/19.
//  Copyright © 2019 Quang Tran. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController, UIScrollViewDelegate {
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var pageControl: UIPageControl!
  @IBOutlet weak var skipButton: UIButton!
  
  var tutorials:[Tutorial] = [];
  let imageNames = [
    "add_list",
    "choose_list_color",
    "tap_list",
    "add_item",
    "add_many_items",
    "mark_finished_item",
    "add_many_lists",
    "sign_out"
  ]
  let descriptions = [
    "Tap the Plus Button at Top Right Corner to Add a New List",
    "Choose the Color that You Love for the List",
    "Tap on the List to Add New Items",
    "Tap the Plus Button at Top Right Corner to Add a New Item",
    "Add More Items as You Want",
    "Tap on Item to Mark It as Finished",
    "Add More Lists as You Want",
    "Tap the Settings Button at Top Left Corner to Sign Out or Show the Tutorial Again"
  ]
  let colors = [
    UIColor(red: 26/255.0, green: 188/255.0, blue: 156/255.0, alpha: 1),
    UIColor(red: 52/255.0, green: 152/255.0, blue: 219/255.0, alpha: 1),
    UIColor(red: 46/255.0, green: 204/255.0, blue: 113/255.0, alpha: 1),
    UIColor(red: 155/255.0, green: 89/255.0, blue: 182/255.0, alpha: 1),
    UIColor(red: 253/255.0, green: 121/255.0, blue: 168/255.0, alpha: 1),
    UIColor(red: 230/255.0, green: 126/255.0, blue: 34/255.0, alpha: 1),
    UIColor(red: 214/255.0, green: 196/255.0, blue: 15/255.0, alpha: 1),
    UIColor(red: 26/255.0, green: 188/255.0, blue: 156/255.0, alpha: 1),
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    scrollView.delegate = self
  }
  
  override func viewDidLayoutSubviews() {
    tutorials = createTutorials()
    setupTutorialScrollView(tutorials: tutorials)
    
    pageControl.numberOfPages = tutorials.count
    pageControl.currentPage = 0
    view.bringSubviewToFront(pageControl)
    
    scrollView.backgroundColor = colors.first
  }
  
  @IBAction func skip(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  func createTutorials() -> [Tutorial] {
    var tutorials = [Tutorial]()
    for i in 0..<imageNames.count {
      let tutorial = Bundle.main.loadNibNamed("Tutorial", owner: self, options: nil)?.first as! Tutorial
      tutorial.imageView.image = UIImage(named: imageNames[i])
      tutorial.labelDesc.text = descriptions[i]
      tutorials.append(tutorial)
    }
    return tutorials
  }
  
  func setupTutorialScrollView(tutorials : [Tutorial]) {
    scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(tutorials.count), height: view.frame.height)
    scrollView.isPagingEnabled = true
    
    for i in 0 ..< tutorials.count {
      tutorials[i].frame = CGRect(x: view.frame.width * CGFloat(i),
                                  y: 0,
                                  width: view.frame.width,
                                  height: view.frame.height)
      scrollView.addSubview(tutorials[i])
    }
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
    pageControl.currentPage = Int(pageIndex)
    
    let title = pageControl.currentPage == imageNames.count - 1 ? "Done" : "Skip"
    skipButton.setTitle(title, for: .normal)
    
    let offset = scrollView.contentOffset.x/view.frame.width
    var low = offset
    low.round(.down)
    let lowIndex = Int(low) < 0 ? 0 : Int(low)
    
    var high = offset
    high.round(.up)
    let highIndex = Int(high) == colors.count ? colors.count - 1 : Int(high)
    
    let startColor = colors[lowIndex]
    let endColor = colors[highIndex]
    let fraction = offset - CGFloat(lowIndex)
    let color = startColor.interpolateTo(endColor, fraction: fraction)
    scrollView.backgroundColor = color
  }
}
