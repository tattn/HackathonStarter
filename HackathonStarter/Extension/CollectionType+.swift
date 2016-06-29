//
//  CollectionType+.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/06/30.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit

extension CollectionType {
    subscript (safe index: Index) -> Generator.Element? {
        get {
            return indices.contains(index) ? self[index] : nil
        }
    }
}
