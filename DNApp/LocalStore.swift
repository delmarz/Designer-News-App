//
//  LocalStore.swift
//  DNApp
//
//  Created by Kryptonite on 4/21/16.
//  Copyright © 2016 Kryptonite. All rights reserved.
//

import UIKit

struct LocalStore {
  static let userDefaults = NSUserDefaults.standardUserDefaults()
  
  static func saveToken(token: String) {
    userDefaults.setObject(token, forKey: "tokenKey")
  }
  
  static func getToken() -> String? {
    return userDefaults.stringForKey("tokenKey")
  }
  
  static func deleteToken() {
    userDefaults.removeObjectForKey("tokenKey")
  }
}
