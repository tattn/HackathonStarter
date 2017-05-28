//
//  EnumEnumerable.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/06/30.
//  Copyright © 2016年 tattn. All rights reserved.
//

import Foundation

public protocol EnumEnumerable {
    associatedtype Case = Self
}

public extension EnumEnumerable where Case: Hashable {
    fileprivate static var generator: AnyIterator<Case> {
        var n = 0
        return AnyIterator {
            defer { n += 1 }
            let next = withUnsafePointer(to: &n) { UnsafeRawPointer($0).load(as: Case.self) }
            return next.hashValue == n ? next : nil
        }
    }

    public static func enumerate() -> EnumeratedSequence<AnySequence<Case>> {
        return AnySequence(generator).enumerated()
    }

    public static var all: [Case] {
        return Array(generator)
    }
}
