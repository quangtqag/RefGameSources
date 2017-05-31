/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

class RegisterViewController: UIViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "User Settings"
    
    // if we already created an attendee, just move on to the conferences list
    guard currentUserID != nil else { return }
    
    performSegue(withIdentifier: "ShowConferencesNonAnimated", sender: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    nameTextField.text = currentUserName
  }
}

// MARK: - IBActions
extension RegisterViewController {
  
  @IBAction func saveButtonPressed() {
    guard let name = nameTextField.text,
      name.characters.count > 0 else {
        print("Please provide valid username")
        return
    }
    
    // either update the attendee's name or create a whole new one on the server
    if let id = currentUserID {
      updateAttendee(id: id, newName: name)
    } else {
      createAttendee(name: name)
    }
  }
}

// MARK: - Internal
extension RegisterViewController {
  
  func createAttendee(name: String) {
    activityIndicator.startAnimating()
    
    // 1
    let createAttendeeMutation = CreateAttendeeMutation(name: name)
    
    // 2
    apollo.perform(mutation: createAttendeeMutation) { [weak self] result, error in
      self?.activityIndicator.stopAnimating()
      
      if let error = error {
        print(error.localizedDescription)
        return
      }
      
      // 3
      currentUserID = result?.data?.createAttendee?.id
      currentUserName = result?.data?.createAttendee?.name
      
      self?.performSegue(withIdentifier: "ShowConferencesAnimated", sender: nil)
    }
  }
  
  func updateAttendee(id: String, newName: String) {
    activityIndicator.startAnimating()
    
    let updateAttendeeNameMutation = UpdateAttendeeNameMutation(id: id, newName: newName)
    apollo.perform(mutation: updateAttendeeNameMutation) { [weak self] result, error in
      self?.activityIndicator.stopAnimating()
      
      if let error = error {
        print(error.localizedDescription)
        return
      }
      
      currentUserID = result?.data?.updateAttendee?.id
      currentUserName = result?.data?.updateAttendee?.name
      
      self?.performSegue(withIdentifier: "ShowConferencesAnimated", sender: nil)
    }
  }
}
