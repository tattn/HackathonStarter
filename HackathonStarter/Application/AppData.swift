//
//  AppData.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/07/21.
//  Copyright © 2016年 tattn. All rights reserved.
//

import Foundation

struct AppData {
    private static let userDefaults = NSUserDefaults.standardUserDefaults()

    static func save(key: AppDataKey, value: AnyObject) {
        userDefaults.setObject(value, forKey: key.rawValue)
        userDefaults.synchronize()
    }

    static func get<T>(key: AppDataKey) -> T? {
        return userDefaults.objectForKey(key.rawValue) as? T
    }

}

enum AppDataKey: String {
    case DeviceToken
    case FirstLaunch
}
