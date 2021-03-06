//
//  RunInfoUseCase.swift
//  speedruntech
//
//  Created by Javier Morgaz García on 15/8/18.
//  Copyright © 2018 Javier Morgaz García. All rights reserved.
//

import UIKit

public protocol RunInfoUseCaseInterface: class {
    
    func getRuns(gameId: String,
                 success: @escaping (([Run]) -> Void),
                 failure: @escaping (() -> Void))
    
    func getUser(userId: String,
                 success: @escaping ((User) -> Void),
                 failure: @escaping (() -> Void))
    
    func openVideoFrom(run: Run) -> Bool
}

class RunInfoUseCase: RunInfoUseCaseInterface {
    
    private let restClient: RestClientInterface
    
    public init(restClient: RestClientInterface) {
        self.restClient = restClient
    }
    
    func getRuns(gameId: String,
                 success: @escaping (([Run]) -> Void),
                 failure: @escaping (() -> Void)) {
        
        let request = GameRouter.runs(baseUrl: restClient.baseUrl, gameId: gameId)
        
        restClient.perform(request: request, success: { runs in
            
            if let runsDictionary = Runs(array: runs as? [JsonDictionary]) {
                success(runsDictionary.runs)
            }
        }, failure: {
            failure()
        })
    }
    
    func getUser(userId: String,
                 success: @escaping ((User) -> Void),
                 failure: @escaping (() -> Void)) {
        
        let request = GameRouter.users(baseUrl: restClient.baseUrl, userId: userId)
        
        restClient.perform(request: request, success: { user in
            
            if let userDictionary = User(jsonDictionary: user as? JsonDictionary) {
                success(userDictionary)
            }
        }, failure: {
            failure()
        })
    }
    
    func openVideoFrom(run: Run) -> Bool {
        
        var canOpenVideo = false
        if let url = URL(string: run.videoUri) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                canOpenVideo = true
            }
        }
        return canOpenVideo
    }
}
