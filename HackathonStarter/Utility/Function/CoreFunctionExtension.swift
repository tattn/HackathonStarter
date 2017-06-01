//
//  CoreFunctionExtension.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/07/01.
//  Copyright © 2016年 tattn. All rights reserved.
//

import Foundation

func print(_ message: String, filename: String = #file, line: Int = #line, function: String = #function) {
    #if DEBUG
    Swift.print("\((filename as NSString).lastPathComponent):\(line) \(function):\r\(message)")
    #endif
}
