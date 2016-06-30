//
//  Async.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/07/01.
//  Copyright © 2016年 tattn. All rights reserved.
//

import Foundation

typealias AsyncProcess = (done: AnyObject? -> ()) -> ()

func parallel(acyncProcesses: [AsyncProcess], completion: [AnyObject?] -> ()) {
    var results = [AnyObject?](count: acyncProcesses.count, repeatedValue: nil)

    let group = dispatch_group_create()
    for (i, acyncProcess) in acyncProcesses.enumerate() {
        dispatch_group_enter(group)
        acyncProcess { result in
            results[i] = result
            dispatch_group_leave(group)
        }
    }

    dispatch_group_notify(group, dispatch_get_main_queue()) {
        completion(results)
    }
}
