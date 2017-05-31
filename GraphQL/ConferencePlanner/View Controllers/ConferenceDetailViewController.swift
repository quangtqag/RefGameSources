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

class ConferenceDetailViewController: UIViewController {

  // MARK: - IBOutlets
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var infoLabel: UILabel!
  @IBOutlet weak var attendingLabel: UILabel!
  @IBOutlet weak var toggleAttendingButton: UIButton!
  @IBOutlet weak var attendeesTableView: UITableView!

  var conference: ConferenceDetails! {
    didSet {
      if isViewLoaded {
        updateUI()
      }
    }
  }
  
  var attendees: [AttendeeDetails]? {
    didSet {
      attendeesTableView.reloadData()
    }
  }
  
  var isCurrentUserAttending: Bool {
    return conference?.isAttendedBy(currentUserID!) ?? false
  }
  
  var conferenceWatcher: GraphQLQueryWatcher<ConferenceDetailsQuery>?
  var attendeesWatcher: GraphQLQueryWatcher<AttendeesForConferenceQuery>?
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Details"
    
    let conferenceDetailsQuery = ConferenceDetailsQuery(id: conference.id)
    conferenceWatcher = apollo.watch(query: conferenceDetailsQuery) { [weak self] result, error in
      guard let conference = result?.data?.conference else { return }
      self?.conference = conference.fragments.conferenceDetails
    }
    
    let attendeesForConferenceQuery = AttendeesForConferenceQuery(conferenceId: conference.id)
    attendeesWatcher = apollo.watch(query: attendeesForConferenceQuery) { [weak self] result, error in
      guard let conference = result?.data?.conference else { return }
      self?.attendees = conference.attendees?.map { $0.fragments.attendeeDetails }
    }
  }
}

// MARK: - IBActions
extension ConferenceDetailViewController {

  @IBAction func attendingButtonPressed() {
    if isCurrentUserAttending {
      let notAttendingConferenceMutation =
        NotAttendConferenceMutation(conferenceId: conference.id,
                                    attendeeId: currentUserID!)
      apollo.perform(mutation: notAttendingConferenceMutation, resultHandler: nil)
    } else {
      let attendingConferenceMutation =
        AttendConferenceMutation(conferenceId: conference.id,
                                 attendeeId: currentUserID!)
      apollo.perform(mutation: attendingConferenceMutation, resultHandler: nil)
    }
  }
}

// MARK: - Internal
extension ConferenceDetailViewController {

  func updateUI() {
    nameLabel.text = conference.name
    infoLabel.text = "\(conference.city), \(conference.year)"
    attendingLabel.text = isCurrentUserAttending ? attendingText : notAttendingText
    toggleAttendingButton.setTitle(isCurrentUserAttending ? attendingButtonText : notAttendingButtonText, for: .normal)
  }
}

// MARK: - UITableViewDataSource
extension ConferenceDetailViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return attendees?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let attendees = self.attendees else { return UITableViewCell() }
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "AttendeeCell")!
    let attendeeDetails = attendees[indexPath.row]
    cell.textLabel?.text = attendeeDetails.name
    let otherConferencesCount = attendeeDetails.numberOfConferencesAttending - 1
    cell.detailTextLabel?.text = "attends \(otherConferencesCount) other conferences"
    return cell
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Attendees"
  }
}
