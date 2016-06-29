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
