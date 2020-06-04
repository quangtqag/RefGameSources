//
//  ListTableViewController.swift
//  CheLis
//
//  Created by Quang Tran on 4/6/19.
//  Copyright © 2019 Quang Tran. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import GoogleSignIn

class ListTableViewController: UITableViewController {
  var lists: [List] = []
  var user: User!
  var ref: DatabaseReference!
  let noteLabel = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 90
    
    noteLabel.text = """
      Tap the Plus Button
      at Top Right Corner
      to Add a New List
    """
    noteLabel.textColor = .darkGray
    noteLabel.textAlignment = .center
    noteLabel.alpha = 0.0
    noteLabel.numberOfLines = 0
    tableView.addSubview(noteLabel)
    
    ref = Database.database().reference().child(user.uid).child(K.Database.lists)
    ref.queryOrdered(byChild: "timestamp").observe(.childAdded, with: { snapshot in
      print("List child added: \(snapshot.value as Any)")
      let list = List(snapshot: snapshot)
      self.lists.insert(list!, at: 0)
      let indexPath = IndexPath(row: 0, section: 0)
      self.tableView.insertRows(at: [indexPath], with: .top)
      self.showHideNoteLabel()
    })
    
    ref.observe(.childRemoved, with: { snapshot in
      print("List child removed: \(snapshot.value as Any)")
      let listToDelete = List(snapshot: snapshot)!
      for (index, list) in self.lists.enumerated() {
        if list.key == listToDelete.key {
          self.lists.remove(at: index)
          let indexPath = IndexPath(row: index, section: 0)
          self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
      }
      self.showHideNoteLabel()
    })
    
    ref.observe(.childChanged, with: { snapshot in
      print("List child changed: \(snapshot.value as Any)")
      let listToMove = List(snapshot: snapshot)!
      for (index, list) in self.lists.enumerated() {
        if list.key == listToMove.key {
          self.lists.remove(at: index)
          self.lists.insert(listToMove, at: 0)
          let srcIndexPath = IndexPath(row: index, section: 0)
          let destIndexPath = IndexPath(row: 0, section: 0)
          self.tableView.moveRow(at: srcIndexPath, to: destIndexPath)
          self.tableView.reloadRows(at: [destIndexPath], with: .none)
        }
      }
    })
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      self.showHideNoteLabel()
    }
  }
  
  func showHideNoteLabel() {
    UIView.animate(withDuration: 1.0) {
      self.noteLabel.alpha = self.lists.count == 0 ? 1.0 : 0.0
    }
  }
  
  override func viewDidLayoutSubviews() {
    noteLabel.frame.size = CGSize(width: 280, height: 100)
    var center = view.center
    center.y -= navigationController!.navigationBar.frame.size.height / 2
    noteLabel.center = center
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.navigationBar.barTintColor = ColorManager.colors.first
  }
  
  override func viewDidAppear(_ animated: Bool) {
    let launchFirstTime = UserDefaults.standard.bool(forKey: K.UserDefaults.launchFirstTime)
    if !launchFirstTime  {
      UserDefaults.standard.set(true, forKey: K.UserDefaults.launchFirstTime)
      let tutorialViewController = TutorialViewController(nibName: "TutorialViewController", bundle: nil)
      self.present(tutorialViewController, animated: true, completion: nil)
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let checkTableViewController = segue.destination as! ItemTableViewController
    checkTableViewController.user = user
    checkTableViewController.list = lists[tableView.indexPathForSelectedRow!.row]
  }
  
  @IBAction func addButtonDidTap(_ sender: Any) {
    let alert = UIStoryboard(name: "Main", bundle: nil)
      .instantiateViewController(withIdentifier: "AdderAlertViewController")
      as! AdderAlertViewController
    alert.modalPresentationStyle = .overFullScreen
    alert.modalTransitionStyle = .crossDissolve
    alert.nameTextFieldPlaceholder = "Enter list name"
    alert.add = { name, colorIndex in
      let list = List(name: name, colorIndex: colorIndex)
      self.ref.childByAutoId().setValue(list.toDict())
    }
    present(alert, animated: true, completion: nil)
  }
  
  @IBAction func moreButtonDidTap(_ sender: Any) {
    let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    sheet.addAction(UIAlertAction(title: "Show Tutorial", style: .default, handler: { (action) in
      let tutorialViewController = TutorialViewController(nibName: "TutorialViewController", bundle: nil)
      self.present(tutorialViewController, animated: true, completion: nil)
    }))
    sheet.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { (action) in
      do {
        try Auth.auth().signOut()
        GIDSignIn.sharedInstance()?.signOut()
        FBSDKLoginManager().logOut()
        
        self.dismiss(animated: true, completion: nil)
      } catch (let error) {
        print("🛑 Auth sign out failed: \(error)")
      }
    }))
    sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    self.present(sheet, animated: true, completion: nil)
  }
}

// MARK: - Table view data source
extension ListTableViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return lists.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListTableViewCell
    let list = lists[indexPath.row]
    cell.list = list
    return cell
  }
}

// MARK: - Table view delegate
extension ListTableViewController {
  override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
      let list = self.lists[indexPath.row]
      let deleteConfirmationAlertController = UIAlertController(
        title: "Delete \"\(list.name)\"?",
        message: "This will permanently delete all the items inside this list. Are you sure want to delete?",
        preferredStyle: .alert)
      
      let yesAction = UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
        list.ref?.removeValue()
        let itemsRef = Database.database().reference()
          .child(self.user.uid)
          .child(K.Database.items)
          .child(list.key)
        itemsRef.removeValue()
      })
      deleteConfirmationAlertController.addAction(yesAction)
      
      let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
      deleteConfirmationAlertController.addAction(noAction)
      
      self.present(deleteConfirmationAlertController, animated: true, completion: nil)
    }
    let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
      let list = self.lists[indexPath.row]
      let alert = UIStoryboard(name: "Main", bundle: nil)
        .instantiateViewController(withIdentifier: "AdderAlertViewController")
        as! AdderAlertViewController
      alert.modalPresentationStyle = .overFullScreen
      alert.modalTransitionStyle = .crossDissolve
      alert.name = list.name
      alert.colorIndex = list.colorIndex
      alert.nameTextFieldPlaceholder = "Enter list name"
      alert.add = { name, colorIndex in
        let updatedList = List(
          name: name,
          colorIndex: colorIndex,
          unfinishedItemsCount: list.unfinishedItemsCount)
        list.ref?.setValue(updatedList.toDict())
      }
      self.present(alert, animated: true, completion: nil)
    }
    editAction.backgroundColor = UIColor(displayP3Red: 26/255.0, green: 188/255.0, blue: 156/255.0, alpha: 1.0)
    return [deleteAction, editAction]
  }
  
  override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
    let cell  = tableView.cellForRow(at: indexPath) as! ListTableViewCell
    cell.isHighlighted = true
  }
  
  override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
    let cell  = tableView.cellForRow(at: indexPath) as! ListTableViewCell
    cell.isHighlighted = false
  }
}
