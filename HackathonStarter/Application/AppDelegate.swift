//
//  AppDelegate.swift
//  HackathonStarter
//
//  Created by Tatsuya Tanaka on 2016/06/30.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit
import Alert
import Version
import UserNotifications
@_exported import SwiftExtensions

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        if UserDefaults.standard.string(for: .previousLaunchAppVersion) == nil {
            // First launching
            // do something
            
            UserDefaults.standard.set("\(Version.current)", for: .previousLaunchAppVersion)
        } else {
            UserDefaults.standard.set("\(Version.current)", for: .previousLaunchAppVersion)
        }
        
        // Launch via push notification
        if let option = launchOptions, let userInfo = option[.remoteNotification] as? [AnyHashable: Any]  {
            PushNotificationManager.handlePushNotification(userInfo, state: application.applicationState)
        }
        
        // if you use push notification
        PushNotificationManager.allowToPushNotification(with: self)
        
        Appearance.setup()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

}

// MARK: - Push Notification
extension AppDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = DeviceToken(data: deviceToken)
        print(token)
        PushNotificationManager.send(token)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        print(userInfo)
        PushNotificationManager.handlePushNotification(userInfo, state: application.applicationState)
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        print("push notification is open")
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        if notification.request.trigger is UNPushNotificationTrigger {
            print("receive a push notification on foreground")
        } else {
            print("receive a local notification on foreground")
        }
        
        switch notification.request.identifier {
        case "alert":
            completionHandler([.alert])
        case "both":
            completionHandler([.alert, .sound])
        default: ()
        }
    }
}
