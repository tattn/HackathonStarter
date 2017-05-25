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

        if UserDefaults.standard.string(for: .previousLaunchAppVersion) == nil {
            // First launching
            UserDefaults.standard.set("version number", for: .previousLaunchAppVersion)
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
        let token = deviceToken.map { String(format: "%.2hhx", $0) }.joined()
        print(token)

        // Send a devicetoken if it was changed
        if UserDefaults.standard.string(for: .deviceToken) != token {
            UserDefaults.standard.set(token, for: .deviceToken)
            PushNotificationManager.sendDeviceToken(token)
        }
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        print(userInfo)
        PushNotificationManager.handlePushNotification(userInfo, state: application.applicationState)
    }
}
