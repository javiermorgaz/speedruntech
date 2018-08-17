//
//  GameListUseCaseTests.swift
//  speedruntechTests
//
//  Created by Javier Morgaz García on 11/8/18.
//  Copyright © 2018 Javier Morgaz García. All rights reserved.
//

import XCTest
@testable import speedruntech

class GameListUseCaseTests: XCTestCase {
    
    private var restClientStub: RestClientStubInterface!
    private var gameListUseCase: GameListUseCase!
    private var resourceUrl: String!
    private var asyncExpectation: XCTestExpectation!
    
    override func setUp() {
        super.setUp()

        //Given
        let bundle = Bundle(for: type(of: self))
        let pathJsonResponseFolder = bundle.url(forResource: "Mocks/Json/Response", withExtension: nil)!.absoluteString
        restClientStub = RestClientStub(baseUrl: pathJsonResponseFolder)
        gameListUseCase = GameListUseCase(restClient: restClientStub)
    }
    
    func test_getGames_Success() {

        //Given
        asyncExpectation = expectation(description: "\(#function)")
        restClientStub.mockPath = "Games/games_ok"
        //When
        gameListUseCase.getGames(success: { games in
        //Then
            XCTAssert(!games.isEmpty)
            self.asyncExpectation.fulfill()

        //When
        }, failure: {
        //Then
            XCTAssert(false)
            self.asyncExpectation.fulfill()

        })
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_getGames_Failure() {
        
        //Given
        asyncExpectation = expectation(description: "\(#function)")
        restClientStub.mockPath = "Games/games_ko"
        //When
        gameListUseCase.getGames(success: { _ in
        //Then
            XCTAssert(false)
            self.asyncExpectation.fulfill()
        //when
        }, failure: {
        //Then
            XCTAssert(true)
            self.asyncExpectation.fulfill()
            
        })
        waitForExpectations(timeout: 1, handler: nil)
    }
}
