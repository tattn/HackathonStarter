//
//  FooModel.swift
//  HackathonStarter
//
//  Created by Tatsuya Tanaka on 2016/07/24.
//  Copyright © 2016年 tattn. All rights reserved.
//

import Foundation
import RealmSwift
import Himotoki
import SwiftDate

final class FooModel: Object {

    fileprivate(set) dynamic var imageUrl: String = ""
    fileprivate(set) dynamic var updatedAt: Date = .init()

    override static func primaryKey() -> String? {
        return "imageUrl"
    }
    
    convenience init(imageUrl: String, updatedAt: String) throws {
        self.init()
        self.imageUrl = imageUrl
        self.updatedAt = try updatedAt.date(format: .custom("yyyy-MM-dd HH:mm:ss"))?.absoluteDate ??? JSONError.parseError
    }
}

extension FooModel: Decodable {
    
    static func decode(_ e: Extractor) throws -> FooModel {
        return try FooModel(
            imageUrl: e <| "imageUrl",
            updatedAt: e <| "updatedAt"
        )
    }
}

extension FooModel {
    static func all() -> [FooModel] {
        if let realm = try? Realm() {
            return Array(realm.objects(self).sorted(byKeyPath: "updatedAt", ascending: false))
        }
        return []
    }
}
