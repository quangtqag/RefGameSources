//
//  K.swift
//  CheLis
//
//  Created by Quang Tran on 4/8/19.
//  Copyright © 2019 Quang Tran. All rights reserved.
//

import Foundation

struct K {
  struct Database {
    static let name = "name"
    static let lists = "lists"
    static let items = "items"
    static let timestamp = "timestamp"
    static let finishedItemsCount = "finishedItemsCount"
    static let unfinishedItemsCount = "unfinishedItemsCount"
    static let colorIndex = "colorIndex"
    static let finished = "finished"
  }
  struct UserDefaults {
    static let launchFirstTime = "launchFirstTime"
  }
}
