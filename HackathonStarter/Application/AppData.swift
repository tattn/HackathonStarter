//
//  AppData.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/07/21.
//  Copyright © 2016年 tattn. All rights reserved.
//

import Foundation

struct AppData {
    fileprivate static let userDefaults = UserDefaults.standard

    static func save(_ key: AppDataKey, value: AnyObject) {
        userDefaults.set(value, forKey: key.rawValue)
        userDefaults.synchronize()
    }

    static func get<T>(_ key: AppDataKey) -> T? {
        return userDefaults.object(forKey: key.rawValue) as? T
    }

}

enum AppDataKey: String {
    case DeviceToken
    case FirstLaunch
}
