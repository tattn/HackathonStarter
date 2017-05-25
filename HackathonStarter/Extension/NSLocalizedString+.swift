//
//  NSLocalizedString+.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/08/12.
//  Copyright © 2016年 tattn. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }

    func localizedWithOption(tableName: String? = nil, bundle: Bundle = Bundle.main, value: String = "") -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: value, comment: self)
    }
}
