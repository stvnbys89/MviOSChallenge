//
//  MindvalleyiOSChallengeTests.swift
//  MindvalleyiOSChallengeTests
//
//  Created by Steven on 28/01/2020.
//  Copyright © 2020 StvnBys. All rights reserved.
//

import XCTest
@testable import MindvalleyiOSChallenge

class MindvalleyiOSChallengeTests: XCTestCase {

    private let cache = Cache<PinboardItem.ID, Data>()
    public var cacheConfig =  CacheConfig()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testSetCacheItem() {
        
        cacheTestData()
        XCTAssertEqual(self.cache.cacheValue(forKey:"item 1"), Data(count: 10))
    }
    
    func testClearCacheItem() {
        
        cacheTestData()
        self.cache.removeCacheValue(forKey: "item 1")
    }
    
    func cacheTestData() {
        
        self.cache.insertCache(Data(count: 10), forKey: "item 1")
        self.cache.insertCache(Data(count: 50), forKey: "item 2")
        self.cache.insertCache(Data(count: 50), forKey: "item 3")
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
