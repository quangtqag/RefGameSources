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
import Apollo

class ConferencesTableViewController: UITableViewController {

  var conferences: [ConferenceDetails] = [] {
    didSet {
      tableView.reloadData()
    }
  }
  
  var allConferencesWatcher: GraphQLQueryWatcher<AllConferencesQuery>?

  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Conferences"

    // create cutom back button
    let backButton = UIBarButtonItem(title: "User", style: .plain, target: self, action: #selector(goBack))
    navigationItem.leftBarButtonItem = backButton
    
    let allConferencesQuery = AllConferencesQuery()
    allConferencesWatcher = apollo.watch(query: allConferencesQuery) { result, error in
      guard let conferences = result?.data?.allConferences else { return }
      self.conferences = conferences.map { $0.fragments.conferenceDetails }
    }
  }

  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let conferenceDetailViewController = segue.destination as! ConferenceDetailViewController
    conferenceDetailViewController.conference = conferences[tableView.indexPathForSelectedRow!.row]
  }
}

// MARK: - Internal
extension ConferencesTableViewController {

  func goBack() {
    navigationController?.popViewController(animated: true)
  }
}

// MARK: - UITableViewDataSource
extension ConferencesTableViewController {

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return conferences.count
  }
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ConferenceCell") as! ConferenceCell
    let conference = conferences[indexPath.row]
    cell.conference = conference
    cell.isCurrentUserAttending = conference.isAttendedBy(currentUserID!)
    return cell
  }
}
