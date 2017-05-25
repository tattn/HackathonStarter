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
        let userDefaults = UserDefaults.standard
        guard let data: Data = userDefaults.object(forKey: String(describing: self)) as? Data else {
            return nil
        }

        return NSKeyedUnarchiver.unarchiveObject(with: data) as? Self
    }

    func storeIntoUserDefaults() {
        let saveData: Data =  NSKeyedArchiver.archivedData(withRootObject: self)
        let userDefaults = UserDefaults.standard
        userDefaults.set(saveData, forKey: String(describing: self))
        userDefaults.synchronize()
    }
}

extension NSCoding where Self: NSObject {

    func restoreAllPropeties(_ decoder: NSCoder) {
        func isSuitableType<T>(_ property: T, key: String) -> Bool {
            return (decoder.decodeObject(forKey: key) as? T) != nil
        }

        let mirror = Mirror(reflecting: self)
        mirror.children.forEach { element in
            guard let key = element.label,
                let cachedValue = decoder.decodeObject(forKey: key) else { return }

            if isSuitableType(element.value, key: key) {
                self.setValue(cachedValue, forKey: key)
            } else {
                assertionFailure("Cached property(\(key)) type is no consistency.")
            }
        }
    }

    func storeAllPropeties(_ coder: NSCoder) {
        let mirror = Mirror(reflecting: self)
        mirror.children.forEach { element in
            if let key = element.label, let value = element.value as? AnyObject {
                coder.encode(value, forKey: key)
            }
        }
    }

}
