//
//  GameInfoDependences.swift
//  speedruntech
//
//  Created by Javier Morgaz García on 12/8/18.
//  Copyright © 2018 Javier Morgaz García. All rights reserved.
//

import UIKit

public class GameInfoDependences {

    public init() {}
    
    public func GameInfoController(game:Game) -> UIViewController {
        
        let gameInfoViewController = GameInfoViewController.instantiate(fromAppStoryboard: .Game)
        let gameInfoUseCase = GameInfoUseCase(restClient: CoreDependences.sharedInstance.restClient)
        let gameInfoPresenter = GameInfoPresenter(gameInfoViewController: gameInfoViewController, gameInfoUseCase: gameInfoUseCase, game: game)
        gameInfoViewController.presenter = gameInfoPresenter
        
        return gameInfoViewController
    }
}
