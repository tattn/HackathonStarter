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
    private static var generator: AnyGenerator<Case> {
        var n = 0
        return AnyGenerator {
            defer { n += 1 }
            let next = withUnsafePointer(&n) { UnsafePointer<Case>($0).memory }
            return next.hashValue == n ? next : nil
        }
    }

    public static func enumerate() -> EnumerateSequence<AnySequence<Case>> {
        return AnySequence(generator).enumerate()
    }

    public static var all: [Case] {
        return Array(generator)
    }
}
