//
//  GameListDependeces.swift
//  speedruntech
//
//  Created by Javier Morgaz García on 11/8/18.
//  Copyright © 2018 Javier Morgaz García. All rights reserved.
//

import UIKit

public class GameListDependences {
    
    public init() {}
    
    public func GameListController(coordinator: GameListCoodinatorDelegate) -> UIViewController {
        
        let gameListViewController = GameListViewController.instantiate(fromAppStoryboard: .Game)
        let gameListUseCase = GameListUseCase(restClient: CoreDependences.sharedInstance.restClient)
        let gameListPresenter = GameListPresenter(gameListViewController: gameListViewController, gameListUseCase: gameListUseCase, coordinator:coordinator)
        gameListViewController.presenter = gameListPresenter
        
        return gameListViewController
    }
}
