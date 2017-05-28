//
//  Operator.swift
//  HackathonStarter
//
//  Created by Tatsuya Tanaka on 20170527.
//  Copyright © 2017年 tattn. All rights reserved.
//

import Foundation

// MARK: - ???

//see: https://gist.github.com/erica/5a26d523f3d6ffb74e34d179740596f7

infix operator ???

func ???<T>(lhs: T?, 
         error: @autoclosure () -> Error) throws -> T {
    guard let value = lhs else { throw error() }
    return value
}

// MARK: - ?=

precedencegroup Comparison {
    associativity: left
    higherThan: LogicalConjunctionPrecedence
}

infix operator ?= : Comparison

public func ?=<T>(lhs: inout T, rhs: T?) {
    guard let value = rhs else { return }
    lhs = value
}

public func ?=<T>(lhs: inout T?, rhs: T?) {
    guard let value = rhs else { return }
    lhs = value
}
