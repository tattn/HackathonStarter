//
//  NSObject+className.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/06/30.
//  Copyright © 2016年 tattn. All rights reserved.
//

import Foundation

extension NSObject {
    class var className: String {
        return String(self)
    }

    var className: String {
        return self.dynamicType.className
    }
}

extension NSObjectProtocol where Self: NSObject {
    var description: String {
        let mirror = Mirror(reflecting: self)
        return mirror.children
            .map { element -> String in
                let key = element.label ?? "Unknown"
                let value = element.value
                return "\(key): \(value)"
            }
            .joinWithSeparator("\n")
    }

}
