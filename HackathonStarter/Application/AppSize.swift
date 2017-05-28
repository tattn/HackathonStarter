//
//  AppSize.swift
//  HackathonStarter
//
//  Created by Tatsuya Tanaka on 2016/07/01.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit

struct AppSize {
    static var screenWidth: CGFloat { return UIScreen.main.bounds.width }
    static var screenHeight: CGFloat { return UIScreen.main.bounds.height }
    static var navigationBarHeight: CGFloat { return 44 }
    static var toolBarHeight: CGFloat { return 44 }
    static var statusBarHeight: CGFloat { return UIApplication.shared.statusBarFrame.height }
    static var statusBarAndNavigationBarHeight: CGFloat { return statusBarHeight + navigationBarHeight }
}
