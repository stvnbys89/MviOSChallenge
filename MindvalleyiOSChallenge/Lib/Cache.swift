//
//  Cache.swift
//  MindvalleyiOSChallenge
//
//  Created by Steven on 04/02/2020.
//  Copyright © 2020 StvnBys. All rights reserved.
//

import UIKit

final class Cache<Key: Hashable, Value> {
    
    
    private let wrapped = NSCache<WrappedKey, Entry>()
    private let dateProvider: () -> Date
    private let entryLifetime: TimeInterval
    
    //entryLifetime 1 hours as default
    //maximumEntryCount 50 as default
    init(dateProvider: @escaping () -> Date = Date.init,
         entryLifetime: TimeInterval = 1 * 60 * 60,
         maximumEntryCount: Int = 50) {
        self.dateProvider = dateProvider
        self.entryLifetime = entryLifetime
        wrapped.countLimit = maximumEntryCount
    }
    
    func insertCache(_ value: Value, forKey key: Key) {
        
        let date = dateProvider().addingTimeInterval(entryLifetime)
        let entry = Entry(value: value, expirationDate: date)
        wrapped.setObject(entry, forKey: WrappedKey(key))
    }

    func cacheValue(forKey key: Key) -> Value? {
        guard let entry = wrapped.object(forKey: WrappedKey(key)) else {
            return nil
        }

        guard dateProvider() < entry.expirationDate else {
            // Discard values that have expired
            removeCacheValue(forKey: key)
            return nil
        }

        return entry.value
    }

    func removeCacheValue(forKey key: Key) {
        wrapped.removeObject(forKey: WrappedKey(key))
    }
    
}

extension Cache {
    subscript(key: Key) -> Value? {
        get { return cacheValue(forKey: key) }
        set {
            guard let value = newValue else {
                // If nil was assigned, then remove any value for that key:
                removeCacheValue(forKey: key)
                return
            }

            insertCache(value, forKey: key)
        }
    }
}

private extension Cache {
    final class WrappedKey: NSObject {
        let key: Key

        init(_ key: Key) { self.key = key }

        override var hash: Int { return key.hashValue }

        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else {
                return false
            }

            return value.key == key
        }
    }
}

private extension Cache {
    final class Entry {
        let value: Value
        let expirationDate: Date

        init(value: Value, expirationDate: Date) {
            self.value = value
            self.expirationDate = expirationDate
        }
    }
}

