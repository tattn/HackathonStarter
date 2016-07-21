//
//  App.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/07/01.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit

struct App {
    static let screenWidth = UIScreen.mainScreen().bounds.width
    static let screenHeight = UIScreen.mainScreen().bounds.height
    static let navigationBarHeight: CGFloat = 44
    static let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
    static let statusBarAndNavigationBarHeight = App.statusBarHeight + App.navigationBarHeight

    static let service = "com.github.foo.bar"
    static let version = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
    static let build = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleVersion") as! String

    struct Color {
        static let main = UIColor.redColor()
    }

    struct Font {
        static func main(size: CGFloat) -> UIFont { return App.Font.hiraKakuW6(size: size) }
        static func hiraKakuW6(size size: CGFloat) -> UIFont { return UIFont(name: "HiraKakuProN-W6", size: size) ?? UIFont.systemFontOfSize(size) }
        static func hiraKakuW3(size size: CGFloat) -> UIFont { return UIFont(name: "HiraKakuProN-W3", size: size) ?? UIFont.systemFontOfSize(size) }
    }
}
