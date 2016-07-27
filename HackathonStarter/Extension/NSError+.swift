//
//  NSError+.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/07/24.
//  Copyright © 2016年 tattn. All rights reserved.
//

import Foundation

extension NSError {
    convenience init(message: String) {
        self.init(domain: App.bundleID, code: 0, userInfo: [NSLocalizedDescriptionKey: message])
    }
}
