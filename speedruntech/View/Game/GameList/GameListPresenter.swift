//
//  GameListPresenter.swift
//  speedruntech
//
//  Created by Javier Morgaz García on 12/8/18.
//  Copyright © 2018 Javier Morgaz García. All rights reserved.
//

import Foundation

public protocol GameListViewInterface {
    
    func update(gameList:[Game])
    func updateFails()
}

public class GameListPresenter : GameListViewControllerDelegate {
    
    public let gameListViewController: GameListViewInterface
    public let gameListUseCase: GameListUseCaseInterface
    
    public var gameList = [Game]()
    
    public init(gameListViewController: GameListViewInterface,
                gameListUseCase: GameListUseCaseInterface) {
        self.gameListViewController = gameListViewController
        self.gameListUseCase = gameListUseCase
    }
    
    public func viewLoaded() {
        
        gameListUseCase.getGames(success: { [weak self] games in
            guard let weakSelf = self else {
                return
            }
            weakSelf.gameListViewController.update(gameList: games)
            
        }, failure: { [weak self] in
            guard let weakSelf = self else {
                return
            }
            weakSelf.gameListViewController.updateFails()
        })
    }
    
    public func gameTapped() {
        
    }
}
