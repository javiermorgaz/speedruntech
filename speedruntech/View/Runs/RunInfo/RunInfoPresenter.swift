//
//  RunInfoPresenter.swift
//  speedruntech
//
//  Created by Javier Morgaz García on 12/8/18.
//  Copyright © 2018 Javier Morgaz García. All rights reserved.
//

import UIKit

public protocol RunInfoViewInterface: BaseViewControllerInterface {
    
    func update(runInfo: RunInfoViewModel)
    func updateFails()
    func openVideoFails()
}

public class RunInfoPresenter: RunInfoViewControllerDelegate {
    
    private let runInfoViewController: RunInfoViewInterface
    private let runInfoUseCase: RunInfoUseCaseInterface
    
    private var game: Game
    private var run: Run?
    private var user: User?
    
    public init(runInfoViewController: RunInfoViewInterface,
                runInfoUseCase: RunInfoUseCaseInterface,
                game: Game) {
        
        self.runInfoViewController = runInfoViewController
        self.runInfoUseCase = runInfoUseCase
        self.game = game
    }
    
    public func viewLoaded() {
        
        updateViewModel()
    }
    
    // MARK: - RunInfoViewControllerDelegate
    public func showVideo() {
        if let run = run {
            if !runInfoUseCase.openVideoFrom(run: run) {
                runInfoViewController.updateFails()
            }
        }
    }
    
    // MARK: - Private Methods
    private func updateViewModel() {
    
        runInfoViewController.presentLoadingNotification()

        guard let run = run else {
            runInfoUseCase.getRuns(gameId: game.gameId, success: { [weak self] runs in
                guard let weakSelf = self else { return }
                weakSelf.run = runs.first
                weakSelf.updateViewModel()
                
                }, failure: { [weak self] in
                    guard let weakSelf = self else { return }
                    weakSelf.runInfoViewController.removeLoadingNotification()
                    weakSelf.runInfoViewController.updateFails()
            })
            return
        }
        
        if user == nil, let playerId = run.playerId {
            runInfoUseCase.getUser(userId: playerId, success: { [weak self] user in
                guard let weakSelf = self else { return }
                weakSelf.user = user
                weakSelf.updateViewModel()
                
                }, failure: { [weak self] in
                    guard let weakSelf = self else { return }
                    weakSelf.runInfoViewController.removeLoadingNotification()
                    weakSelf.runInfoViewController.updateFails()
            })
            return
        }
        
        updateInfoView()
    }
    
    private func updateInfoView() {
        
        var userName = ""
        if let playerName = run?.playerName {
            userName = playerName
        } else if let name = user?.name {
            userName = name
        }
        
        if let run = run {
            let runInfoModel = RunInfoViewModel(gameName: game.name,
                                                  logoUri: game.logoUri,
                                                  userName: userName,
                                                  time: run.time)
            runInfoViewController.update(runInfo: runInfoModel)
        }
        runInfoViewController.removeLoadingNotification()
    }
}
