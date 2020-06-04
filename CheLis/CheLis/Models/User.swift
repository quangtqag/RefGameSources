import Foundation
import Firebase

struct User {
  
  let uid: String
  
  init(authData: Firebase.User) {
    uid = authData.uid
  }
  
  init(uid: String) {
    self.uid = uid
  }
}
