//
//  GameInfoPresenter.swift
//  speedruntech
//
//  Created by Javier Morgaz García on 12/8/18.
//  Copyright © 2018 Javier Morgaz García. All rights reserved.
//

import UIKit

public protocol GameInfoViewInterface: BaseViewControllerInterface {
    
    func update(gameInfo:GameInfoViewModel)
    func updateFails()
}

public class GameInfoPresenter: GameInfoViewControllerDelegate {
    
    private let gameInfoViewController: GameInfoViewInterface
    private let gameInfoUseCase: GameInfoUseCaseInterface
    
    private var game: Game
    private var run: Run?
    private var user: User?
    
    public init(gameInfoViewController: GameInfoViewInterface,
                gameInfoUseCase: GameInfoUseCaseInterface,
                game: Game) {
        
        self.gameInfoViewController = gameInfoViewController
        self.gameInfoUseCase = gameInfoUseCase
        self.game = game
    }
    
    public func viewLoaded() {
        
        updateViewModel()
    }
    
    // MARK: - GameInfoViewControllerDelegate
    public func showVideo() {
        if let run = run, let url = URL(string: run.videoUri) {
            if UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
    
    // MARK: - Private Methods
    private func updateViewModel() {
    
        gameInfoViewController.presentLoadingNotification()

        guard let run = run else {
            gameInfoUseCase.getRuns(gameId: game.gameId, success: { [weak self] runs in
                guard let weakSelf = self else { return }
                weakSelf.run = runs.first
                weakSelf.updateViewModel()
                
                }, failure: { [weak self] in
                    guard let weakSelf = self else { return }
                    weakSelf.gameInfoViewController.removeLoadingNotification()
                    weakSelf.gameInfoViewController.updateFails()
            })
            return
        }
        
        if user == nil {
            gameInfoUseCase.getUser(userId: run.playerId, success: { [weak self] user in
                guard let weakSelf = self else { return }
                weakSelf.user = user
                weakSelf.updateViewModel()
                
                }, failure: { [weak self] in
                    guard let weakSelf = self else { return }
                    weakSelf.gameInfoViewController.removeLoadingNotification()
                    weakSelf.gameInfoViewController.updateFails()
            })
            return
        }
        
        updateInfoView()
    }
    
    private func updateInfoView() {
        
        if let run = run, let user = user {
            let gameInfoModel = GameInfoViewModel(gameName: game.name,
                                                  logoUri: game.logoUri,
                                                  userName: user.name,
                                                  time: run.time)
            gameInfoViewController.update(gameInfo: gameInfoModel)
        }
        gameInfoViewController.removeLoadingNotification()
    }
}
