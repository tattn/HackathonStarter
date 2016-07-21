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


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
        application.applicationIconBadgeNumber = 0
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }


}

//MARK:- Push Notification
extension AppDelegate {

    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
    }

    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        application.registerForRemoteNotifications()
    }

    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        // Convert devicetoken
        let tokenAsString = deviceToken.description.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "<>")).stringByReplacingOccurrencesOfString(" ", withString: "")
        print(tokenAsString)

        // Send devicetoken if it was changed
        if let deviceToken: String = AppData.get(.DeviceToken) where deviceToken == tokenAsString {
        } else {
            AppData.save(.DeviceToken, value: tokenAsString)
            PushNotificationManager.shared.sendDeviceToken(tokenAsString)
        }
    }

    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        print(userInfo)
        PushNotificationManager.shared.handlePushNotification(userInfo, state: application.applicationState)
    }
}
