//
//  HogeModel.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/07/24.
//  Copyright © 2016年 tattn. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class HogeModel: Object {

    dynamic var imageUrl = "http://***.png"

    dynamic var updatedAt = NSDate()

    override static func primaryKey() -> String? {
        return "imageUrl"
    }

    required convenience init?(_ map: Map) {
        self.init()
        mapping(map)
    }
}

extension HogeModel: Mappable {

    func mapping(map: Map) {
        imageUrl <- map["imageUrl"]
        //updatedAt <- (map["updatedAt"], DateTransform()) // unixtime
        updatedAt <- (map["updatedAt"], CustomDateFormatTransform(formatString: "yyyy-MM-dd HH:mm:ss"))
    }
}

extension HogeModel {
    static func all() -> [HogeModel] {
        if let realm = try? Realm() {
            return Array(realm.objects(self).sorted("updatedAt", ascending: false))
        }
        return []
    }
}
