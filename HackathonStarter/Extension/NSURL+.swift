//
//  NSURL+.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/06/30.
//  Copyright © 2016年 tattn. All rights reserved.
//

import Foundation

extension String {
    var url: NSURL? {
        return NSURL(string: self)
    }
}
