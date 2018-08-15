//
//  GameCoordinator.swift
//  speedruntech
//
//  Created by Javier Morgaz García on 11/8/18.
//  Copyright © 2018 Javier Morgaz García. All rights reserved.
//

import UIKit

class GameCoodinator: Coordinator {
    
    // MARK: - Public attributes
    public var gameNavigationController = UINavigationController()
    
    public init() {}
    
    // MARK: - Pulic methods
   public func start() -> UINavigationController {
        
        self.presentGameList()
        return gameNavigationController
    }
    
    private func presentGameList() {
        let gameListDependeces = GameListDependences()
        gameNavigationController.show(gameListDependeces.GameListController(coordinator: self), sender: self)
    }
}

extension GameCoodinator:GameListCoodinatorDelegate {
    
    func presentGameInfo(game: Game) {
        let gameInfoDependeces = GameInfoDependences()
        gameNavigationController.show(gameInfoDependeces.GameInfoController(game:game), sender: self)
    }
}

