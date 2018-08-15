//
//  GameListUseCase.swift
//  speedruntech
//
//  Created by Javier Morgaz García on 11/8/18.
//  Copyright © 2018 Javier Morgaz García. All rights reserved.
//

import Foundation

public protocol GameListUseCaseInterface: class {
    
    func getGames(success: @escaping (([Game]) -> Void),
                  failure: @escaping (() -> Void))
}

class GameListUseCase: GameListUseCaseInterface {
    
    private let restClient: RestClientInterface

    public init(restClient: RestClientInterface) {
        self.restClient = restClient
    }
    
    public func getGames(success: @escaping (([Game]) -> Void),
                         failure: @escaping (() -> Void)) {
        
        let request = GameRouter.games(baseUrl: restClient.baseUrl)
        
        restClient.perform(request: request,success: { games in
            
            if let gamesDictionary = Games(array: games as? [JsonDictionary]) {
                success(gamesDictionary.games)
            }
            
        }, failure: {
            failure()
        })
    }
}
