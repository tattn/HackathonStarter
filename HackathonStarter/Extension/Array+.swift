//
//  Array+.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/07/04.
//  Copyright © 2016年 tattn. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    @discardableResult
    mutating func remove(element: Element) -> Bool {
        guard let index = index(of: element) else { return false }
        self.remove(at: index)
        return true
    }

    mutating func remove(elements: [Element]) {
        for element in elements {
            remove(element: element)
        }
    }
}
