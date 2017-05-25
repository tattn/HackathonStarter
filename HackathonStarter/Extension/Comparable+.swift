//
//  Comparable+.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/06/30.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit

extension Comparable {
    func clamped(min: Self, max: Self) -> Self {
        if self < min {
            return min
        }

        if self > max {
            return max
        }

        return self
    }
}
