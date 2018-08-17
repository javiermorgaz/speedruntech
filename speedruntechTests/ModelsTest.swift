//
//  ModelsTest.swift
//  speedruntechTests
//
//  Created by Javier Morgaz García on 17/8/18.
//  Copyright © 2018 Javier Morgaz García. All rights reserved.
//

import XCTest
@testable import speedruntech

class ModelsTest: XCTestCase {
    
    func test_Game_Valid() {
        
        //Given
        let jsonDictionary = TestUtils.jsonModel(withName: "Game_ok")
        //When
        let game = Game(jsonDictionary: jsonDictionary)
        //Then
        XCTAssertEqual(game?.name, "! Fishy !")
    }
    
    func test_Game_Invalid() {
        
        //Given
        let jsonDictionary = TestUtils.jsonModel(withName: "Game_ko")
        //When
        let game = Game(jsonDictionary: jsonDictionary)
        //Then
        XCTAssertEqual(game?.name, "")
    }
    
    func test_Run_Valid() {
        
        //Given
        let jsonDictionary = TestUtils.jsonModel(withName: "Run_ok")
        //When
        let run = Run(jsonDictionary: jsonDictionary)
        //Then
        XCTAssertEqual(run?.playerId, "qjogd7ex")
    }
    
    func test_Run_Invalid() {
        
        //Given
        let jsonDictionary = TestUtils.jsonModel(withName: "Run_ko")
        //When
        let run = Run(jsonDictionary: jsonDictionary)
        //Then
        XCTAssertEqual(run?.videoUri, "")
    }
    
    func test_User_Valid() {
        
        //Given
        let jsonDictionary = TestUtils.jsonModel(withName: "User_ok")
        //When
        let user = User(jsonDictionary: jsonDictionary)
        //Then
        XCTAssertEqual(user?.name, "PurpleSun")
        
    }
    
    func test_User_Invalid() {
        
        //Given
        let jsonDictionary = TestUtils.jsonModel(withName: "User_ko")
        //When
        let user = User(jsonDictionary: jsonDictionary)
        //Then
        XCTAssertEqual(user?.name, "")
    }
    
    func test_RestResponse_Valid() {
        
        //Given
        let jsonDictionary = TestUtils.jsonModel(withName: "RestResponse_ok")
        //When
        let restResponse = RestResponse(jsonDictionary: jsonDictionary)
        //Then
        XCTAssertNotNil(restResponse?.result)
    }
    
    func test_RestResponse_Invalid() {
        
        //Given
        let jsonDictionary = TestUtils.jsonModel(withName: "RestResponse_ko")
        //When
        let restResponse = RestResponse(jsonDictionary: jsonDictionary)
        //Then
        XCTAssertNil(restResponse?.result)
    }
}
