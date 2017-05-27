//
//  NotificationKey.swift
//  HackathonStarter
//
//  Created by Tatsuya Tanaka on 20170527.
//  Copyright © 2017年 tattn. All rights reserved.
//

import Foundation

extension Notification.Name {
    public static var sample: Notification.Name { return "sample" }
}

extension Notification.Name: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: String) {
        self = Notification.Name(value)
    }
    
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(stringLiteral: value)
    }
    
    public init(unicodeScalarLiteral value: String) {
        self.init(stringLiteral: value)
    }
}
