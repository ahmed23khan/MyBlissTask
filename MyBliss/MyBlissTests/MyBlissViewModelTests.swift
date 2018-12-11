//
//  MyBlissViewModelTests.swift
//  MyBlissTests
//
//  Created by Tauqeer Ahmed Khan on 11/12/18.
//  Copyright © 2018 Tauqeer Ahmed Khan. All rights reserved.
//

import XCTest
@testable import MyBliss

class MyBlissViewModelTests: XCTestCase {
    
    var sut: MyBlissViewModel!
    var mockAPIService: MockApiService!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        mockAPIService = MockApiService()
        sut = MyBlissViewModel(apiService: mockAPIService)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func test_fetch_episodes() {
        // Given
        mockAPIService.completePhotos = [Episodes]()
        
        // When
        sut.initFetch()
        
        // Assert
        XCTAssert(mockAPIService!.isFetchPopularEpisodeCalled)
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

class MockApiService: APIServiceProtocol {

    var isFetchPopularEpisodeCalled = false
    
    var completePhotos: [Episodes] = [Episodes]()
    var completeClosure: (([Episodes], Error?) -> ())!
    
    func fetchData(completionHandler: @escaping ([Episodes]?, Error?) -> ()) {
        isFetchPopularEpisodeCalled = true
        completeClosure = completionHandler
    }
    
    func fetchSuccess() {
        completeClosure( completePhotos, nil )
    }
    
    func fetchFail(error: Error?) {
        completeClosure( completePhotos, error )
    }
    
}
