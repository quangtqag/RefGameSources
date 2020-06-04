import Foundation
import Firebase

struct Item {
  
  let ref: DatabaseReference?
  let key: String
  let name: String
  var finished: Bool
  
  init(name: String, finished: Bool = false, key: String = "") {
    self.ref = nil
    self.key = key
    self.name = name
    self.finished = finished
  }
  
  init?(snapshot: DataSnapshot) {
    guard
      let value = snapshot.value as? [String: AnyObject],
      let name = value[K.Database.name] as? String,
      let completed = value[K.Database.finished] as? Bool else {
      return nil
    }
    
    self.ref = snapshot.ref
    self.key = snapshot.key
    self.name = name
    self.finished = completed
  }
  
  func toDict() -> [String: Any] {
    return [
      K.Database.name: name,
      K.Database.finished: finished,
      K.Database.timestamp: ServerValue.timestamp()
    ]
  }
}
