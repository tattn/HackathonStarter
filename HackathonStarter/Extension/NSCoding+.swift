//
//  NSCoding+.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/07/27.
//  Copyright © 2016年 tattn. All rights reserved.
//

import Foundation

protocol Serializable {
}

extension NSObject: Serializable {
}

extension Serializable where Self: NSCoding {
    func restoreFromUserDefaults() -> Self? {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        guard let data: NSData = userDefaults.objectForKey(String(self)) as? NSData else {
            return nil
        }

        return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? Self
    }

    func storeIntoUserDefaults() {
        let saveData: NSData =  NSKeyedArchiver.archivedDataWithRootObject(self)
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(saveData, forKey: String(self))
        userDefaults.synchronize()
    }
}

extension NSCoding where Self: NSObject {

    func restoreAllPropeties(decoder: NSCoder) {
        func isSuitableType<T>(property: T, key: String) -> Bool {
            return (decoder.decodeObjectForKey(key) as? T) != nil
        }

        let mirror = Mirror(reflecting: self)
        mirror.children.forEach { element in
            guard let key = element.label,
                cachedValue = decoder.decodeObjectForKey(key) else { return }

            if isSuitableType(element.value, key: key) {
                self.setValue(cachedValue, forKey: key)
            } else {
                assertionFailure("Cached property(\(key)) type is no consistency.")
            }
        }
    }

    func storeAllPropeties(coder: NSCoder) {
        let mirror = Mirror(reflecting: self)
        mirror.children.forEach { element in
            if let key = element.label, value = element.value as? AnyObject {
                coder.encodeObject(value, forKey: key)
            }
        }
    }

}
