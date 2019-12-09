//
//  Constants.swift
//  MemeMe
//
//  Created by Kappa on 2019/12/9.
//  Copyright © 2019 qi. All rights reserved.
//

import Foundation

struct Constants {
  
  static let rowHeight = 150.0
  static let itemSpace = 3.0
  
  struct StoryboardID {
    static let detailViewID = "MemeDetailViewController"
  }
}

extension Notification.Name {
  static let didSaveMeme = Notification.Name("didSaveMeme")
}
