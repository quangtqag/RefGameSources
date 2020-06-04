import Foundation
import Firebase

struct List {
  
  let ref: DatabaseReference?
  let key: String
  let name: String
  let colorIndex: Int
  let finishedItemsCount: Int
  let unfinishedItemsCount: Int
  
  init(
    name: String,
    colorIndex: Int = 0,
    itemsCount: Int = 0,
    unfinishedItemsCount: Int = 0,
    key: String = ""
    ) {
    self.ref = nil
    self.key = key
    self.name = name
    self.colorIndex = colorIndex
    self.finishedItemsCount = itemsCount
    self.unfinishedItemsCount = unfinishedItemsCount
  }
  
  init?(snapshot: DataSnapshot) {
    guard
      let value = snapshot.value as? [String: Any],
      let name = value[K.Database.name] as? String,
      let colorIndex = value[K.Database.colorIndex] as? Int,
      let finishedItemsCount = value[K.Database.finishedItemsCount] as? Int,
      let unfinishedItemsCount = value[K.Database.unfinishedItemsCount] as? Int
      else {
      return nil
    }
    
    self.ref = snapshot.ref
    self.key = snapshot.key
    self.name = name
    self.colorIndex = colorIndex
    self.finishedItemsCount = finishedItemsCount
    self.unfinishedItemsCount = unfinishedItemsCount
  }
  
  func toDict() -> [String: Any] {
    return [
      K.Database.name: name,
      K.Database.colorIndex: colorIndex,
      K.Database.finishedItemsCount: finishedItemsCount,
      K.Database.unfinishedItemsCount: unfinishedItemsCount,
      K.Database.timestamp: ServerValue.timestamp()
    ]
  }
}
