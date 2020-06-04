//
//  ItemTableViewController.swift
//  CheLis
//
//  Created by Quang Tran on 4/7/19.
//  Copyright © 2019 Quang Tran. All rights reserved.
//

import UIKit
import Firebase

class ItemTableViewController: UITableViewController {
  var unfinishedItems: [Item] = []
  var finishedItems: [Item] = []
  var user: User!
  var list: List!
  var ref: DatabaseReference!
  let noteLabel = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = list.name
    navigationController?.navigationBar.barTintColor = ColorManager.colors[list.colorIndex]
    
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 60
    
    noteLabel.text = """
    Tap the Plus Button
    at Top Right Corner
    to Add a New Item
    """
    noteLabel.textColor = .darkGray
    noteLabel.textAlignment = .center
    noteLabel.alpha = 0.0
    noteLabel.numberOfLines = 0
    tableView.addSubview(noteLabel)
    
    ref = Database.database()
      .reference()
      .child(user.uid)
      .child(K.Database.items)
      .child(list.key)
    
//    Database.database().reference()
//      .child(user.uid)
//      .child(K.Database.lists)
//      .child(list.key)
//      .updateChildValues([K.Database.timestamp: ServerValue.timestamp()])
    
    ref.queryOrdered(byChild: K.Database.timestamp).observe(.childAdded, with: { snapshot in
      print("Item child added: \(snapshot.value as Any)")
      let item = Item(snapshot: snapshot)!
      var section = 0
      if item.finished {
        self.finishedItems.insert(item, at: 0)
        section = 1
      }
      else {
        self.unfinishedItems.insert(item, at: 0)
      }
      let indexPath = IndexPath(row: 0, section: section)
      self.tableView.insertRows(at: [indexPath], with: .top)
      
      Database.database().reference()
        .child(self.user.uid)
        .child(K.Database.lists)
        .child(self.list.key)
        .updateChildValues([K.Database.unfinishedItemsCount: self.unfinishedItems.count])
      self.showHideNoteLabel()
    })
    
    ref.observe(.childRemoved, with: { snapshot in
      print("Item child removed: \(snapshot.value as Any)")
      let itemToDelete = Item(snapshot: snapshot)!
      for (index, item) in self.unfinishedItems.enumerated() {
        if item.key == itemToDelete.key {
          self.unfinishedItems.remove(at: index)
          let indexPath = IndexPath(row: index, section: 0)
          self.tableView.deleteRows(at: [indexPath], with: .fade)
          
          Database.database().reference()
            .child(self.user.uid)
            .child(K.Database.lists)
            .child(self.list.key)
            .updateChildValues([K.Database.unfinishedItemsCount: self.unfinishedItems.count])
        }
      }
      for (index, item) in self.finishedItems.enumerated() {
        if item.key == itemToDelete.key {
          self.finishedItems.remove(at: index)
          let indexPath = IndexPath(row: index, section: 1)
          self.tableView.deleteRows(at: [indexPath], with: .fade)
          
          Database.database().reference()
            .child(self.user.uid)
            .child(K.Database.lists)
            .child(self.list.key)
            .updateChildValues([K.Database.finishedItemsCount: self.finishedItems.count])
        }
      }
      self.showHideNoteLabel()
    })
    
    ref.observe(.childChanged, with: { snapshot in
      print("Item child changed: \(snapshot.value as Any)")
      let itemToUpdate = Item(snapshot: snapshot)!
      let itemsContain = self.unfinishedItems.contains(where: { $0.key == itemToUpdate.key })
      if itemsContain {
        for (index, item) in self.unfinishedItems.enumerated() {
          if item.key == itemToUpdate.key {
            if itemToUpdate.finished {
              self.unfinishedItems.remove(at: index)
              self.finishedItems.insert(itemToUpdate, at: 0)
              let srcIndexPath = IndexPath(row: index, section: 0)
              let destIndexPath = IndexPath(row: 0, section: 1)
              self.tableView.moveRow(at: srcIndexPath, to: destIndexPath)
              self.tableView.reloadRows(at: [destIndexPath], with: .none)
              
              Database.database().reference()
                .child(self.user.uid)
                .child(K.Database.lists)
                .child(self.list.key)
                .updateChildValues([
                  K.Database.finishedItemsCount: self.finishedItems.count,
                  K.Database.unfinishedItemsCount: self.unfinishedItems.count
                  ])
            }
            else {
              self.unfinishedItems.remove(at: index)
              self.unfinishedItems.insert(itemToUpdate, at: index)
              let indexPath = IndexPath(row: index, section: 0)
              self.tableView.reloadRows(at: [indexPath], with: .none)
            }
            break
          }
        }
      }
      else {
        for (index, item) in self.finishedItems.enumerated() {
          if item.key == itemToUpdate.key {
            if !itemToUpdate.finished {
              self.finishedItems.remove(at: index)
              self.unfinishedItems.insert(itemToUpdate, at: 0)
              let srcIndexPath = IndexPath(row: index, section: 1)
              let destIndexPath = IndexPath(row: 0, section: 0)
              self.tableView.moveRow(at: srcIndexPath, to: destIndexPath)
              self.tableView.reloadRows(at: [destIndexPath], with: .none)
              
              Database.database().reference()
                .child(self.user.uid)
                .child(K.Database.lists)
                .child(self.list.key)
                .updateChildValues([
                  K.Database.unfinishedItemsCount: self.unfinishedItems.count,
                  K.Database.finishedItemsCount: self.finishedItems.count
                  ])
            }
            else {
              self.finishedItems.remove(at: index)
              self.finishedItems.insert(itemToUpdate, at: index)
              let indexPath = IndexPath(row: index, section: 1)
              self.tableView.reloadRows(at: [indexPath], with: .none)
            }
            break
          }
        }
      }
    })
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      self.showHideNoteLabel()
    }
  }
  
  func showHideNoteLabel() {
    UIView.animate(withDuration: 1.0) {
      self.noteLabel.alpha = self.unfinishedItems.count + self.finishedItems.count == 0 ? 1.0 : 0.0
    }
  }
  
  override func viewDidLayoutSubviews() {
    if let navigationController = navigationController {
      noteLabel.frame.size = CGSize(width: 280, height: 100)
      var center = view.center
      center.y -= navigationController.navigationBar.frame.size.height / 2
      noteLabel.center = center
    }
  }
  
  @IBAction func addButtonDidTap(_ sender: Any) {
    let alert = UIStoryboard(name: "Main", bundle: nil)
      .instantiateViewController(withIdentifier: "AdderAlertViewController")
      as! AdderAlertViewController
    alert.modalPresentationStyle = .overFullScreen
    alert.modalTransitionStyle = .crossDissolve
    alert.removeColorPicker = true
    alert.nameTextFieldPlaceholder = "Enter item name"
    alert.add = { name, colorIndex in
      let item = Item(name: name)
      self.ref.childByAutoId().setValue(item.toDict())
    }
    present(alert, animated: true, completion: nil)
  }
}

// MARK: - Table view data source
extension ItemTableViewController {
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return section == 0 ? unfinishedItems.count : finishedItems.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemTableViewCell
    let item = indexPath.section == 0 ? unfinishedItems[indexPath.row] : finishedItems[indexPath.row]
    cell.item = item
    return cell
  }
}

// MARK: - Table view delegate
extension ItemTableViewController {
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let item = unfinishedItems[indexPath.row]
      item.ref?.removeValue()
    }
  }
  
  override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
      let item = indexPath.section == 0
        ? self.unfinishedItems[indexPath.row]
        : self.finishedItems[indexPath.row]
      item.ref?.removeValue()
    }
    let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
      let item = indexPath.section == 0
        ? self.unfinishedItems[indexPath.row]
        : self.finishedItems[indexPath.row]
      let alert = UIStoryboard(name: "Main", bundle: nil)
        .instantiateViewController(withIdentifier: "AdderAlertViewController")
        as! AdderAlertViewController
      alert.modalPresentationStyle = .overFullScreen
      alert.modalTransitionStyle = .crossDissolve
      alert.removeColorPicker = true
      alert.nameTextFieldPlaceholder = "Enter item name"
      alert.name = item.name
      alert.add = { name, colorIndex in
        item.ref?.updateChildValues([K.Database.name : name])
      }
      self.present(alert, animated: true, completion: nil)
    }
    editAction.backgroundColor = UIColor(displayP3Red: 26/255.0, green: 188/255.0, blue: 156/255.0, alpha: 1.0)
    return [deleteAction, editAction]
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) else { return }
    let itemCell = cell as! ItemTableViewCell
    var item = indexPath.section == 0
      ? self.unfinishedItems[indexPath.row]
      : self.finishedItems[indexPath.row]
    item.finished = !item.finished
    itemCell.item = item
    item.ref?.updateChildValues([
      K.Database.finished: item.finished,
      K.Database.timestamp: ServerValue.timestamp()
      ])
  }
  
  override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
    let cell  = tableView.cellForRow(at: indexPath) as! ItemTableViewCell
    cell.isHighlighted = true
  }
  
  override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
    let cell  = tableView.cellForRow(at: indexPath) as! ItemTableViewCell
    cell.isHighlighted = false
  }
}
