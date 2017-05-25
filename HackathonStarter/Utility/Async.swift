//
//  Async.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/07/01.
//  Copyright © 2016年 tattn. All rights reserved.
//

import Foundation

typealias AsyncProcess = (_ done: (AnyObject?) -> ()) -> ()

func parallel(_ acyncProcesses: [AsyncProcess], completion: @escaping ([AnyObject?]) -> ()) {
    var results = [AnyObject?](repeating: nil, count: acyncProcesses.count)

    let group = DispatchGroup()
    for (i, acyncProcess) in acyncProcesses.enumerated() {
        group.enter()
        acyncProcess { result in
            results[i] = result
            group.leave()
        }
    }

    group.notify(queue: DispatchQueue.main) {
        completion(results)
    }
}

func threadOnMain(_ block: @escaping ()->()) {
    DispatchQueue.main.async(execute: block)
}

func threadOnBackground(_ name: String = "background", block: @escaping ()->()) {
    DispatchQueue(label: name, attributes: []).async(execute: block)
}
