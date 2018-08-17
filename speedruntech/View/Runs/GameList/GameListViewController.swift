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
    func tapped(game: Game)
}

class GameListViewController: BaseViewController, GameListViewInterface {
    
    private let rowHeight = CGFloat(70)
    
    @IBOutlet weak var gamesTableView: UITableView!
    
    weak var delegate: GameListViewControllerDelegate?
    
    public var presenter: GameListPresenter? {
        didSet {
            delegate = presenter
        }
    }
    
    private var games: [Game] = [] {
        didSet {
            gamesTableView.reloadData()
        }
    }
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpViewController()
        delegate?.viewLoaded()
    }
    
    // MARK: GameListViewInterface
    func update(gameList: [Game]) {
        games = gameList
    }
    
    func updateFails() {
        
        let cancelAction = UIAlertAction(title: "alertCancel".localized(), style: .cancel) { _ in }
        let retryAction = UIAlertAction(title: "alertRetry".localized(), style: .default) { _ in
            self.delegate?.viewLoaded()
        }
        showAlert(title: "alertTitle".localized(), message: "alertGameListMessage".localized(), actions: [cancelAction, retryAction])
    }

    // MARK: Private Methods
    private func setUpViewController() {
        title = "navigationListTitle".localized()
        gamesTableView.estimatedRowHeight = rowHeight
    }
}

extension GameListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let gameCell = gamesTableView.dequeueReusableCell(withIdentifier: String(describing: GameListTableViewCell.self)) as? GameListTableViewCell {
            gameCell.updateCell(model: games[indexPath.row])
            return gameCell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.tapped(game: games[indexPath.row])
    }
}
