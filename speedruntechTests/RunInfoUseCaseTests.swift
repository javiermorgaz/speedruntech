//
//  RunInfoUseCaseTests.swift
//  speedruntechTests
//
//  Created by Javier Morgaz García on 16/8/18.
//  Copyright © 2018 Javier Morgaz García. All rights reserved.
//

import XCTest
import CocoaLumberjack
@testable import speedruntech

class RunInfoUseCaseTests: XCTestCase {
    
    private var restClientStub: RestClientStubInterface!
    private var runInfoUseCase: RunInfoUseCase!
    private var resourceUrl: String!
    private var asyncExpectation: XCTestExpectation!
    
    override func setUp() {
        super.setUp()

        //Given
        let bundle = Bundle(for: type(of: self))
        let pathJsonResponseFolder = bundle.url(forResource: "Mocks/Json/Response", withExtension: nil)!.absoluteString
        restClientStub = RestClientStub(baseUrl: pathJsonResponseFolder)
        runInfoUseCase = RunInfoUseCase(restClient: restClientStub)
    }
    
    func test_getRuns_Success() {
        
        //Given
        asyncExpectation = expectation(description: "\(#function)")
        restClientStub.mockPath = "Runs/runs_ok"
        //When
        runInfoUseCase.getRuns(gameId: "", success: { runs in
        //Then
            XCTAssert(!runs.isEmpty)
            self.asyncExpectation.fulfill()
    
        //When
        }, failure: {
        //Then
            XCTAssert(false)
            self.asyncExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_getRuns_Failure() {
        
        //Given
        asyncExpectation = expectation(description: "\(#function)")
        restClientStub.mockPath = "Runs/runs_ko"
        //When
        runInfoUseCase.getRuns(gameId: "", success: { _ in
        //Then
            XCTAssert(false)
            self.asyncExpectation.fulfill()
            
        //When
        }, failure: {
        //Then
            XCTAssert(true)
            self.asyncExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_getUser_Success() {
        
        //Given
        asyncExpectation = expectation(description: "\(#function)")
        restClientStub.mockPath = "User/user_ok"
        //When
        runInfoUseCase.getUser(userId: "", success: { user in
        //Then
            XCTAssert(!user.name.isEmpty)
            self.asyncExpectation.fulfill()
            
        //When
        }, failure: {
        //Then
            XCTAssert(false)
            self.asyncExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_getUser_Failure() {
        
        //Given
        asyncExpectation = expectation(description: "\(#function)")
        restClientStub.mockPath = "User/user_ko"
        //When
        runInfoUseCase.getUser(userId: "", success: { _ in
        //Then
            XCTAssert(false)
            self.asyncExpectation.fulfill()
            
        //When
        }, failure: {
        //Then
            XCTAssert(true)
            self.asyncExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_openVideo_Succes() {
        
        //Given
        let jsonDictionary = TestUtils.jsonModel(withName: "Run_ok")
        //When
        guard let run = Run(jsonDictionary: jsonDictionary) else {
            return
        }
        //Then
        XCTAssertTrue(runInfoUseCase.openVideoFrom(run: run))
    }
    
    func test_openVideo_Failure() {
        
        //Given
        let jsonDictionary = TestUtils.jsonModel(withName: "Run_ko")
        //When
        guard let run = Run(jsonDictionary: jsonDictionary) else {
            return
        }        //Then
        XCTAssertFalse(runInfoUseCase.openVideoFrom(run: run))
    }
}
