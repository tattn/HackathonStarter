//
//  NSError+.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/07/24.
//  Copyright © 2016年 tattn. All rights reserved.
//

import Foundation

extension NSError {
    convenience init(code: Int = 0, message: String) {
        self.init(domain: Bundle.main.bundleIdentifier!, code: code, userInfo: [NSLocalizedDescriptionKey: message])
    }
}
