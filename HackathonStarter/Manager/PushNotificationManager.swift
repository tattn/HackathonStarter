//
//  PushNotificationManager.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/07/21.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit

struct PushNotificationManager {

    static func allowToPushNotification() {
        let application = UIApplication.shared
        let type: UIUserNotificationType = [.alert, .badge, .sound]
        let setting = UIUserNotificationSettings(types: type, categories: nil)
        application.registerUserNotificationSettings(setting)
        application.registerForRemoteNotifications()
    }

    static func sendDeviceToken(_ deviceToken: String) {
        // send devicetoken to server
    }

    static func handlePushNotification(_ userInfo: [AnyHashable: Any], state: UIApplicationState) {
        switch state {
        case .inactive:
            // Launch via push notification
            break
        case .active:
            break
        case .background:
            break
        }
    }

}
