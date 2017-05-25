//
//  App.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/07/01.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit

struct App {
    static var screenWidth: CGFloat { return UIScreen.main.bounds.width }
    static var screenHeight: CGFloat { return UIScreen.main.bounds.height }
    static var navigationBarHeight: CGFloat { return 44 }
    static var toolBarHeight: CGFloat { return 44 }
    static var statusBarHeight: CGFloat { return UIApplication.shared.statusBarFrame.height }
    static var statusBarAndNavigationBarHeight: CGFloat { return statusBarHeight + navigationBarHeight }

    static let bundleID = Bundle.main.bundleIdentifier!
    static let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    static let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String

    struct Color {
        static let main = UIColor.red
    }

    struct Font {
        static func main(_ size: CGFloat) -> UIFont { return App.Font.hiraKakuW6(size: size) }
        static func hiraKakuW6(size: CGFloat) -> UIFont { return UIFont(name: "HiraKakuProN-W6", size: size) ?? UIFont.systemFont(ofSize: size) }
        static func hiraKakuW3(size: CGFloat) -> UIFont { return UIFont(name: "HiraKakuProN-W3", size: size) ?? UIFont.systemFont(ofSize: size) }
    }


    static func setupDefaultAppearance() {
        // Icon color on Nav
        UINavigationBar.appearance().tintColor = Color.main

        // Text color on Nav
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: Color.main]

        // Text color (UIButton & UIAlertView & ...)
        UIView.appearance().tintColor = Color.main
    }

}
