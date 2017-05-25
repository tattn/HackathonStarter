//
//  AppDelegate.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/06/30.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        if AppData.get(.FirstLaunch) == nil {
            // First launching
            AppData.save(.FirstLaunch, value: false as AnyObject)
        } else {
            RealmManager.migrate()
        }

        // Launch via push notification
        if let launch = launchOptions {
            if let userInfo = launch[UIApplicationLaunchOptionsKey.remoteNotification] as? [AnyHashable: Any] {
                PushNotificationManager.handlePushNotification(userInfo, state: application.applicationState)
            }
        }

        App.setupDefaultAppearance()

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

//MARK:- Push Notification
extension AppDelegate {

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }

    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        application.registerForRemoteNotifications()
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Convert a devicetoken
        let tokenAsString = deviceToken.description.trimmingCharacters(in: CharacterSet(charactersIn: "<>")).replacingOccurrences(of: " ", with: "")
        print(tokenAsString)

        // Send a devicetoken if it was changed
        if let deviceToken: String = AppData.get(.DeviceToken), deviceToken == tokenAsString {
        } else {
            AppData.save(.DeviceToken, value: tokenAsString as AnyObject)
            PushNotificationManager.sendDeviceToken(tokenAsString)
        }
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        print(userInfo)
        PushNotificationManager.handlePushNotification(userInfo, state: application.applicationState)
    }
}
