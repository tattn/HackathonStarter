//
//  Dictionary+.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/07/13.
//  Copyright © 2016年 tattn. All rights reserved.
//

import Foundation

extension Dictionary {
    // See http://ericasadun.com/2015/07/08/swift-merging-dictionaries/
    mutating func merge<S: Sequence>(_ other: S) where S.Iterator.Element == (key: Key, value: Value) {
        for (key, value) in other {
            self[key] = value
        }
    }

    func merged<S: Sequence>(_ other: S) -> [Key: Value] where S.Iterator.Element == (key: Key, value: Value) {
        var dic = self
        dic.merge(other)
        return dic
    }
}
