//
//  Appearance.swift
//  HackathonStarter
//
//  Created by Tatsuya Tanaka on 20170529.
//  Copyright © 2017年 tattn. All rights reserved.
//

import Foundation
import UIKit

struct Appearance {
    static func setup() {
        // Icon color of NavigationBar
        UINavigationBar.appearance().tintColor = .main
        
        // Text color of NavigationBar
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.main]
        
        // Text color (UIButton & UIAlertView & ...)
        UIView.appearance().tintColor = .main
    }
}

extension UIColor {
    static var main: UIColor { return .red }
}

extension UIFont {
    static func main(ofSize size: CGFloat) -> UIFont {
        return .hiraKakuW6(ofSize: size)
    }
    
    static func hiraKakuW6(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "HiraKakuProN-W6", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func hiraKakuW3(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "HiraKakuProN-W3", size: size) ?? .systemFont(ofSize: size)
    }
}
