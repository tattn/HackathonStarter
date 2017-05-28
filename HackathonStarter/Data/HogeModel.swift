//
//  HogeModel.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/07/24.
//  Copyright © 2016年 tattn. All rights reserved.
//

import Foundation
import RealmSwift
import Himotoki
import SwiftDate

final class HogeModel: Object {

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

extension HogeModel: Decodable {
    
    static func decode(_ e: Extractor) throws -> HogeModel {
        return try HogeModel(
            imageUrl: e <| "imageUrl",
            updatedAt: e <| "updatedAt"
        )
    }
}

extension HogeModel {
    static func all() -> [HogeModel] {
        if let realm = try? Realm() {
            return Array(realm.objects(self).sorted(byKeyPath: "updatedAt", ascending: false))
        }
        return []
    }
}
