//
//  RunInfoDependences.swift
//  speedruntech
//
//  Created by Javier Morgaz García on 12/8/18.
//  Copyright © 2018 Javier Morgaz García. All rights reserved.
//

import UIKit

public class RunInfoDependences {

    public init() {}
    
    public func RunInfoController(game:Game) -> UIViewController {
        
        let runInfoViewController = RunInfoViewController.instantiate(fromAppStoryboard: .Game)
        let runInfoUseCase = RunInfoUseCase(restClient: CoreDependences.sharedInstance.restClient)
        let runInfoPresenter = RunInfoPresenter(runInfoViewController: runInfoViewController, runInfoUseCase: runInfoUseCase, game: game)
        runInfoViewController.presenter = runInfoPresenter
        
        return runInfoViewController
    }
}
