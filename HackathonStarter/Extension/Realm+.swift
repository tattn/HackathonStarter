//
//  Realm+.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/07/20.
//  Copyright © 2016年 tattn. All rights reserved.
//

import Foundation
import RealmSwift
import Version

protocol RealmType {}
extension Object: RealmType {}
extension Array: RealmType {}

extension Realm {
    static func migrate() {
        let build = UInt64("\(Version.currentBuildNumber)")!
        let config = Realm.Configuration(schemaVersion: build)
        
        Realm.Configuration.defaultConfiguration = config
        
        do {
            _ = try Realm()
        } catch {
            print("realm migrate error")
        }
    }
}

private func realmBlock(_ block: (Realm) throws -> Void) -> Bool {
    do {
        try block(try Realm())
        return true
    } catch {
        print(error)
    }
    return false
}

// MARK: - Write
extension RealmType where Self: Object {

    @discardableResult
    func write(_ block: (Realm) -> Void) -> Bool {
        return realmBlock { realm in
            try realm.write {
                block(realm)
            }
        }
    }

    @discardableResult
    func save() -> Bool {
        return write { realm in
            realm.add(self, update: true)
        }
    }

    func saveAsync() {
        DispatchQueue.global().async {
            self.save()
        }
    }

}

extension Array where Element: Object {

    @discardableResult
    func write(_ block: (Realm) -> Void) -> Bool {
        return realmBlock { realm in
            try realm.write {
                block(realm)
            }
        }
    }

    @discardableResult
    func save() -> Bool {
        return write { realm in
            realm.add(self, update: true)
        }
    }

    func saveAsync() {
        DispatchQueue.global().async {
            self.save()
        }
    }
}

// MARK: - Read
extension RealmType where Self: Object {

    static func all() -> [Self] {
        if let realm = try? Realm() {
            return Array(realm.objects(Self.self))
        }
        return []
    }

    static func findAll(_ predicateFormat: String, _ args: Any...) -> [Self] {
        if let realm = try? Realm() {
            return Array(realm.objects(Self.self).filter(predicateFormat, args))
        }
        return []
    }
}

// MARK: - Delete
extension RealmType where Self: Object {
    @discardableResult
    static func deleteAll(_ predicateFormat: String, _ args: Any...) -> Bool {
        return realmBlock { realm in
            let results = realm.objects(Self.self).filter(predicateFormat, args)
            
            try realm.write {
                realm.delete(results)
            }
        }
    }

    @discardableResult
    func delete() -> Bool {
        return write { realm in
            realm.delete(self)
        }
    }
}

extension Array where Element: Object {
    @discardableResult
    func delete() -> Bool {
        return write { realm in
            realm.delete(self)
        }
    }
}
