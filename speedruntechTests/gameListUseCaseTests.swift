//
//  gameListUseCaseTests.swift
//  speedruntechTests
//
//  Created by Javier Morgaz García on 11/8/18.
//  Copyright © 2018 Javier Morgaz García. All rights reserved.
//

import XCTest
@testable import speedruntech

class gameListUseCaseTests: XCTestCase {
    
    private var restClientStub: RestClientStubInterface!
    private var gameListUseCase: GameListUseCase!
    private var resourceUrl:String!
    private var asyncExpectation: XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let bundle = Bundle(for: type(of: self))
        let pathJsonFolder = bundle.url(forResource: "Mocks/Json", withExtension: nil)!.absoluteString
        restClientStub = RestClientStub(baseUrl: pathJsonFolder)
        gameListUseCase = GameListUseCase(restClient: restClientStub)

    }
    
    func test_getGames_Success() {
        // This is an example of a functional test case.
        asyncExpectation = expectation(description: "\(#function)")
        restClientStub.mockPath = "games_ok"
        gameListUseCase.getGames(success: { games in
            XCTAssert(!games.isEmpty)
            self.asyncExpectation.fulfill()

        }, failure: {
            XCTAssert(false)
            self.asyncExpectation.fulfill()

        })
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_getGames_Failure() {
        // This is an example of a functional test case.
        asyncExpectation = expectation(description: "\(#function)")
        restClientStub.mockPath = "games_ko"
        gameListUseCase.getGames(success: { games in
            XCTAssert(false)
            self.asyncExpectation.fulfill()
            
        }, failure: {
            XCTAssert(true)
            self.asyncExpectation.fulfill()
            
        })
        waitForExpectations(timeout: 1, handler: nil)
    }
}
