//
//  URL+.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/06/30.
//  Copyright © 2016年 tattn. All rights reserved.
//

import Foundation

extension String {
    var url: URL? {
        return URL(string: self)
    }
}

extension URL: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: String) {
        guard let url = URL(string: value) else {
            fatalError("\(value) is not a valid url")
        }
        self = url
    }
    
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(stringLiteral: value)
    }
    
    public init(unicodeScalarLiteral value: String) {
        self.init(stringLiteral: value)
    }
}
