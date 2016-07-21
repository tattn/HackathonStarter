//
//  RealmManager.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/07/21.
//  Copyright © 2016年 tattn. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmManager {
    static let shared = RealmManager()


    func migrate() {
        let build = UInt64(App.build)!
        
        let config = Realm.Configuration(
            schemaVersion: build,
            migrationBlock: {(migration, oldSchemaVersion) -> Void in
        })
        
        Realm.Configuration.defaultConfiguration = config
        
        // Do migrate
        do {
            _ = try Realm()
        } catch {
            print("realm migrate error")
        }
    }
}
