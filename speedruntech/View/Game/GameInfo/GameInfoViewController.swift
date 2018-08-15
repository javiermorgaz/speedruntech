//
//  GameInfoViewController.swift
//  speedruntech
//
//  Created by Javier Morgaz García on 12/8/18.
//  Copyright © 2018 Javier Morgaz García. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

public struct GameInfoViewModel {
    let gameName: String
    let logoUri: String
    let userName: String
    let time: String
}

public protocol GameInfoViewControllerDelegate: class {
    
    func viewLoaded()
    func showVideo()
}

class GameInfoViewController : BaseViewController, GameInfoViewInterface {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var playerTitleLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var timeTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var videoButton: UIButton!
    
    weak var delegate: GameInfoViewControllerDelegate?
    
    public var presenter: GameInfoPresenter? {
        didSet {
            delegate = presenter
        }
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpViewController()
        delegate?.viewLoaded()
    }
    
    // MARK: - IBActions
    @IBAction func videoButtonAction(_ sender: Any) {
        delegate?.showVideo()
    }
    
    // MARK: GameInfoViewInterface
    func update(gameInfo: GameInfoViewModel) {
        
        nameLabel.text = gameInfo.gameName
        playerTitleLabel.text = "user".localized()
        playerNameLabel.text = gameInfo.userName
        timeTitleLabel.text = "time".localized()
        timeLabel.text = gameInfo.time
        videoButton.setTitle("video".localized(), for: .normal)
        if let url = URL(string: gameInfo.logoUri) {
            logoImageView.sd_setImage(with: url, placeholderImage: nil)
        }
    }
    
    func updateFails() {
        
        let cancelAction = UIAlertAction(title: "alertCancel".localized(), style: .cancel) { _ in }
        let okAction = UIAlertAction(title: "alertRetry".localized(), style: .default) { _ in
            self.delegate?.viewLoaded()
        }
        
        showAlert(title: "alertTitle".localized(), message: "alertGameInfoMessage".localized(), actions: [cancelAction, okAction])
    }
    
    // MARK: - Private Methods
    private func setUpViewController() {
        title = "navigationInfoTitle".localized()
    }
}
