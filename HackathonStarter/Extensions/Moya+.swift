//
//  Moya+.swift
//  HackathonStarter
//
//  Created by Tatsuya Tanaka on 2019/07/25.
//  Copyright © 2019 Tatsuya Tanaka. All rights reserved.
//

import Foundation
import Moya

extension TargetType {
    var sampleData: Data {
        Data()
    }
}

open class DebugMoyaProvider<Target: TargetType>: MoyaProvider<Target> {
    convenience init() {
        let stubClosure = { (target: Target) -> StubBehavior in
            return .never
        }
        let networkLoggerPlugin = NetworkLoggerPlugin(cURL: true)
        let plugins = [networkLoggerPlugin]
        self.init(stubClosure: stubClosure, plugins: plugins)
    }
}
