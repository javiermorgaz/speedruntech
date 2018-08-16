//
//  GameListPresenter.swift
//  speedruntech
//
//  Created by Javier Morgaz García on 12/8/18.
//  Copyright © 2018 Javier Morgaz García. All rights reserved.
//

import Foundation

public protocol GameListViewInterface: BaseViewControllerInterface {
    
    func update(gameList:[Game])
    func updateFails()
}

public protocol GameListCoodinatorDelegate {
    func presentRunInfo(game:Game)
}

public class GameListPresenter : GameListViewControllerDelegate {
    
    private let gameListViewController: GameListViewInterface
    private let gameListUseCase: GameListUseCaseInterface
    private var delegate:GameListCoodinatorDelegate?
    
    private var gameList = [Game]()
    
    public init(gameListViewController: GameListViewInterface,
                gameListUseCase: GameListUseCaseInterface,
                coordinator: GameListCoodinatorDelegate) {
        
        self.gameListViewController = gameListViewController
        self.gameListUseCase = gameListUseCase
        self.delegate = coordinator
    }
    
    public func viewLoaded() {
        
        gameListViewController.presentLoadingNotification()
        gameListUseCase.getGames(success: { [weak self] games in
            
            guard let weakSelf = self else { return }
            weakSelf.gameListViewController.update(gameList: games)
            weakSelf.gameListViewController.removeLoadingNotification()
        }, failure: { [weak self] in
            
            guard let weakSelf = self else { return }
            weakSelf.gameListViewController.removeLoadingNotification()
            weakSelf.gameListViewController.updateFails()
        })
    }
    
    public func tapped(game:Game) {
        delegate?.presentRunInfo(game: game)
    }
}