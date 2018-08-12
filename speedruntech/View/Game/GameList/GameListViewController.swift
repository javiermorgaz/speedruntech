//
//  GameListViewController.swift
//  speedruntech
//
//  Created by Javier Morgaz García on 11/8/18.
//  Copyright © 2018 Javier Morgaz García. All rights reserved.
//

import Foundation
import UIKit

public protocol GameListViewControllerDelegate: class {
    
    func viewLoaded()
    func gameTapped()
}

class GameListViewController : BaseViewController, GameListViewInterface {
    
    weak var delegate: GameListViewControllerDelegate?
    
    public var presenter: GameListPresenter? {
        didSet {
            delegate = presenter
        }
    }
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate?.viewLoaded()
    }
    
    // MARK: GameListViewInterface
    func update(gameList: [Game]) {
        
    }
    
    func updateFails() {
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            self.delegate?.viewLoaded()
        }
        
        showAlert(title: "Error", message: "Error getting games", actions: [cancelAction, okAction])
    }

}
