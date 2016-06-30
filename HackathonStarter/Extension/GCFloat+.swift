//
//  GCFloat+.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/06/30.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit

extension CGFloat {
    func clamped(min min: CGFloat, max: CGFloat) -> CGFloat {
        if self < min {
            return min
        }

        if self > max {
            return max
        }

        return self
    }
}
