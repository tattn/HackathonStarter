//
//  UserDefaultsKey.swift
//  HackathonStarter
//
//  Created by Tatsuya Tanaka on 20170526.
//  Copyright © 2017年 tattn. All rights reserved.
//

import Foundation
import UserDefaults

extension UserDefaults.Key {
    public static var deviceToken: UserDefaults.Key { return "deviceToken" }
    public static var previousLaunchAppVersion: UserDefaults.Key { return "previousLaunchAppVersion" }
}
