//
//  KeyChainManager.swift
//  HackathonStarter
//
//  Created by 田中　達也 on 2016/07/21.
//  Copyright © 2016年 tattn. All rights reserved.
//

import Foundation
import KeychainAccess

struct KeychainManager {
    static func get(_ key: String, service: String? = nil) -> String? {
        var token: String?

        let keychain = getKeychain(service)

        do {
            token = try keychain.get(key)

            if token == nil {
                token = try getFailBackOldDataKey(key)
            }
        } catch let error {
            print(error)
        }
        
        return token
    }

    fileprivate static func getFailBackOldDataKey(_ key: String) throws -> String? {
        var query = [String: AnyObject]()
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrAccount as String] = key.data(using: String.Encoding.utf8) as AnyObject
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnData as String] = kCFBooleanTrue

        var result: AnyObject?
        let status = withUnsafeMutablePointer(to: &result) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }

        // see: https://github.com/kishikawakatsumi/KeychainAccess/blob/master/Lib/KeychainAccess/Keychain.swift#L507
        // see: https://github.com/kishikawakatsumi/KeychainAccess/blob/master/Lib/KeychainAccess/Keychain.swift#L1001
        switch status {
        case errSecSuccess:
            guard let data = result as? Data else {
                throw Status.unexpectedError
            }
            guard let string = String(data: data, encoding: String.Encoding.utf8) else {
                throw Status.unexpectedError
            }
            return string
        case errSecItemNotFound:
            return nil
        default:
            let message = Status(status: status).description
            let error = NSError(domain: KeychainAccessErrorDomain, code: Int(status), userInfo: [NSLocalizedDescriptionKey: message])
            throw error
        }
    }

    static func set(_ key: String, value: String, service: String? = nil) {
        let keychain = getKeychain(service)

        do {
            try keychain.set(value, key: key)
        } catch let error {
            print(error)
        }
    }
    
    static func remove(_ key: String, service: String? = nil) {
        let keychain = getKeychain(service)

        do {
            try keychain.remove(key)
        } catch let error {
            print(error)
        }
    }

    fileprivate static func getKeychain(_ service: String? = nil) -> Keychain {
        if let service = service {
            return Keychain(service: service)
        } else {
            return Keychain()
        }
    }

}
