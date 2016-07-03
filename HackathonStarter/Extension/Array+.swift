//
//  Array+.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/07/04.
//  Copyright © 2016年 tattn. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    mutating func remove(element element: Element) -> Bool {
        guard let index = indexOf(element) else { return false }
        removeAtIndex(index)
        return true
    }

    mutating func remove(elements elements: [Element]) {
        for element in elements {
            remove(element: element)
        }
    }
}
