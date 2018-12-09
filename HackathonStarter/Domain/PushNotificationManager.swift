//
//  PushNotificationManager.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/07/21.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit
import UserNotifications

public struct DeviceToken {
    public let data: Data
    
    public init(data: Data) {
        self.data = data
    }
}

extension DeviceToken: CustomStringConvertible {
    public var description: String {
        return data.map { String(format: "%.2hhx", $0) }.joined()
    }
}

struct PushNotificationManager {
    static func allowToPushNotification(with appDelegate: AppDelegate) {
        let center = UNUserNotificationCenter.current()
        center.delegate = appDelegate
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print(error)
                return
            }

            if granted {
                print("Push notification is granted")
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else {
                print("Push notification is NOT granted")
            }
        }
    }
    
    static func send(_ token: DeviceToken) {
        if UserDefaults.standard.string(for: .deviceToken) != token.description {
            UserDefaults.standard.set(token.description, for: .deviceToken)
            // send devicetoken to server
        }
    }

    static func handlePushNotification(_ userInfo: [AnyHashable: Any], state: UIApplication.State) {
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
