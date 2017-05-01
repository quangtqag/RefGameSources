//
//  ViewController.swift
//  UndoRedo
//
//  Created by Quang Tran on 4/28/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var numberTF: UITextField!
  @IBOutlet weak var textTF: UITextField!
  var currentTF: UITextField!
  var isUpdate = false
  var undoItem: UIBarButtonItem!
  var redoItem: UIBarButtonItem!
  var numberUndoManager = UndoManager()
  var textUndoManager = UndoManager()
  var currentUndoManager: UndoManager!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Config toolbar
    self.undoItem = UIBarButtonItem(image: UIImage(named: "undo"),
                                    style: UIBarButtonItemStyle.plain,
                                    target: self,
                                    action: #selector(undoItemDidTap(sender:)))
    self.redoItem = UIBarButtonItem(image: UIImage(named: "redo"),
                                    style: UIBarButtonItemStyle.plain,
                                    target: self,
                                    action: #selector(redoItemDidTap(sender:)))
    let spaceItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
    let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(doneItemDidTap(sender:)))
    let toolbar = UIToolbar()
    toolbar.setItems([self.undoItem, self.redoItem, spaceItem, doneItem], animated: false)
    toolbar.sizeToFit()
    self.undoItem.isEnabled = false
    self.redoItem.isEnabled = false
    
    // Config text fields
    self.numberTF.keyboardType = UIKeyboardType.numberPad
    self.numberTF.delegate = self
    self.numberTF.inputAccessoryView = toolbar
    
    // Config text fields
    self.textTF.keyboardType = UIKeyboardType.asciiCapable
    self.textTF.delegate = self
    self.textTF.inputAccessoryView = toolbar
  }
  
  override func viewDidAppear(_ animated: Bool) {
    self.numberTF.becomeFirstResponder()
  }
  
  func updateString(string: String) {
    self.currentUndoManager.registerUndo(withTarget: self, selector: #selector(updateString(string:)), object: self.currentTF.text!)
    self.currentUndoManager.setActionName("Update String")
    if isUpdate == true {
      self.currentTF.text = string
    }
    self.updateUndoRedoButtonState()
  }
  
  func undoItemDidTap(sender: UIBarButtonItem) {
    self.currentUndoManager.undo()
    self.updateUndoRedoButtonState()
  }
  
  func redoItemDidTap(sender: UIBarButtonItem) {
    self.currentUndoManager.redo()
    self.updateUndoRedoButtonState()
  }
 
  func doneItemDidTap(sender: UIBarButtonItem) {
    self.view.endEditing(true)
  }
  
  func updateUndoRedoButtonState() {
    self.undoItem.isEnabled = self.currentUndoManager.canUndo
    self.redoItem.isEnabled = self.currentUndoManager.canRedo
  }
}

extension ViewController: UITextFieldDelegate {
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    self.currentUndoManager = textField == numberTF ? self.numberUndoManager : self.textUndoManager
    self.currentTF = textField
    self.updateUndoRedoButtonState()
  }
  
  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {
    
    let changedStr = (textField.text! as NSString).replacingCharacters(in: range, with: string)
    self.isUpdate = false
    self.updateString(string: changedStr)
    self.isUpdate = true
    return true
  }
}


