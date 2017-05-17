//
//  MenuViewController.swift
//  Taasky
//
//  Created by Audrey M Tam on 18/03/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {
  
  lazy var menuItems: NSArray = {
    let path = Bundle.main.path(forResource: "MenuItems", ofType: "plist")
    return NSArray(contentsOfFile: path!)!
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Remove the drop shadow from the navigation bar
    navigationController!.navigationBar.clipsToBounds = true
    
    (navigationController!.parent as! ContainerViewController).menuItem = (menuItems[0] as! NSDictionary)
  }
  
  // MARK: UITableViewDelegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let menuItem = menuItems[indexPath.row] as! NSDictionary
    (navigationController!.parent as! ContainerViewController).menuItem = menuItem
  }
  
  // MARK: - Table View
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return menuItems.count
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    // adjust row height so items all fit into view
    return max(80, view.bounds.height / CGFloat(menuItems.count))
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell") as! MenuItemCell
    let menuItem = menuItems[indexPath.row] as! NSDictionary
    cell.configureForMenuItem(menuItem)
    return cell
  }
  
}
