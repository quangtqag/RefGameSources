//
//  AddListAlertViewController.swift
//  CheLis
//
//  Created by Quang Tran on 4/10/19.
//  Copyright © 2019 Quang Tran. All rights reserved.
//

import UIKit

class AdderAlertViewController: UIViewController {
  @IBOutlet weak var cancelButton: UIButton!
  @IBOutlet weak var addButton: UIButton!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var colorStackView: UIStackView!
  @IBOutlet weak var alertView: UIView!
  @IBOutlet weak var colorBackgroundView: UIView!
  @IBOutlet weak var containerStackView: UIStackView!
  
  var add: ((_ name: String, _ colorIndex: Int) -> Void)?
  var name = ""
  var colorIndex = 0
  var removeColorPicker = false
  var nameTextFieldPlaceholder = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if removeColorPicker {
      containerStackView.removeArrangedSubview(colorBackgroundView)
      colorBackgroundView.removeFromSuperview()
    }
    
    alertView.backgroundColor = ColorManager.colors[colorIndex]
    
    cancelButton.layer.addBorder(edge: .top, color: .lightGray, thickness: 1)
    cancelButton.layer.addBorder(edge: .right, color: .lightGray, thickness: 1)
    addButton.layer.addBorder(edge: .top, color: .lightGray, thickness: 1)
    
    nameTextField.delegate = self
    nameTextField.text = name
    nameTextField.placeholder = nameTextFieldPlaceholder
    
    for (index, colorSubview) in colorStackView!.arrangedSubviews.enumerated() {
      let colorButton = colorSubview as! ColorButton
      colorButton.addTarget(self, action: #selector(colorButtonDidTap(_:)), for: .touchUpInside)
      colorButton.tag = index
      if index == colorIndex {
        colorButton.isSelected = true
      }
    }
    
    addButton.isEnabled = !name.isEmpty
    addButton.setTitle(name.isEmpty ? "Add" : "Update", for: .normal)
    NotificationCenter.default.addObserver(
      forName: UITextField.textDidChangeNotification,
      object: nameTextField,
      queue: OperationQueue.main) { (notification) in
        self.addButton.isEnabled = !self.nameTextField.text!.isEmpty
    }
  }
  
  @objc func colorButtonDidTap(_ sender: ColorButton) {
    for colorSubview in colorStackView.arrangedSubviews {
      let colorButton = colorSubview as! ColorButton
      colorButton.isSelected = false
    }
    sender.isSelected = true
    colorIndex = sender.tag
    alertView.backgroundColor = sender.color
  }
  
  override func viewDidAppear(_ animated: Bool) {
    nameTextField.becomeFirstResponder()
  }
  
  @IBAction func cancelButtonDidTap() {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func addButtonDidTap() {
    dismiss(animated: true) {
      self.add?(self.nameTextField.text!, self.colorIndex)
    }
  }
}

extension AdderAlertViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    addButtonDidTap()
    return true
  }
}
