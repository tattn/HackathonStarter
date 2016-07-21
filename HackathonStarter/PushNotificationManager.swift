//
//  PushNotificationManager.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/07/21.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit

struct PushNotificationManager {

    static let shared = PushNotificationManager()

    func allowToPushNotification() {
        let application = UIApplication.sharedApplication()
        let type: UIUserNotificationType = [.Alert, .Badge, .Sound]
        let setting = UIUserNotificationSettings(forTypes: type, categories: nil)
        application.registerUserNotificationSettings(setting)
        application.registerForRemoteNotifications()
    }

    func sendDeviceToken(deviceToken: String) {
        // send devicetoken to server
    }

    func handlePushNotification(userInfo: [NSObject : AnyObject], state: UIApplicationState) {
        switch state {
        case .Inactive:
            // Launch via push notification
            break
        case .Active:
            break
        case .Background:
            break
        }
    }

}
