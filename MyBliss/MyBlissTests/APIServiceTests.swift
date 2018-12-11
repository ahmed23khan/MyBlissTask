//
//  APIServiceTests.swift
//  MyBlissTests
//
//  Created by Tauqeer Ahmed Khan on 11/12/18.
//  Copyright © 2018 Tauqeer Ahmed Khan. All rights reserved.
//

import XCTest
@testable import MyBliss

class APIServiceTests: XCTestCase {
    
    var sut: MyBlissManager?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = MyBlissManager()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }

    func test_fetch_episodes() {
        
        // Given A apiservice
        let sut = self.sut!
        
        // When fetch popular photo
        let expect = XCTestExpectation(description: "callback")
        
        sut.fetchData { (episodes, error) in
            expect.fulfill()
            XCTAssertEqual( episodes!.count, 10)
            for episode in episodes! {
                XCTAssertNotNil(episode.id)
            }
            
        }
        
        wait(for: [expect], timeout: 3.1)
    }

}
