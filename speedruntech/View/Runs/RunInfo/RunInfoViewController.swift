//
//  RunInfoViewController.swift
//  speedruntech
//
//  Created by Javier Morgaz García on 12/8/18.
//  Copyright © 2018 Javier Morgaz García. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

public struct RunInfoViewModel {
    
    let gameName: String
    let logoUri: String
    let userName: String
    let time: String
}

public protocol RunInfoViewControllerDelegate: class {
    
    func viewLoaded()
    func showVideo()
}

class RunInfoViewController: BaseViewController, RunInfoViewInterface {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var playerTitleLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var timeTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var videoButton: UIButton!
    
    weak var delegate: RunInfoViewControllerDelegate?
    
    public var presenter: RunInfoPresenter? {
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
    
    // MARK: RunInfoViewInterface
    func update(runInfo: RunInfoViewModel) {
        
        nameLabel.text = runInfo.gameName
        playerTitleLabel.text = "user".localized()
        playerNameLabel.text = runInfo.userName
        timeTitleLabel.text = "time".localized()
        timeLabel.text = runInfo.time
        videoButton.setTitle("video".localized(), for: .normal)
        if let url = URL(string: runInfo.logoUri) {
            logoImageView.sd_setImage(with: url, placeholderImage: nil)
        }
    }
    
    func updateFails() {
        
        let cancelAction = UIAlertAction(title: "alertCancel".localized(), style: .cancel) { _ in }
        let retryAction = UIAlertAction(title: "alertRetry".localized(), style: .default) { _ in
            self.delegate?.viewLoaded()
        }
        showAlert(title: "alertTitle".localized(), message: "alertRunInfoMessage".localized(), actions: [cancelAction, retryAction])
    }
    
    func openVideoFails() {
        
        let okAction = UIAlertAction(title: "alertOk".localized(), style: .default) { _ in }
        showAlert(title: "alertTitle".localized(), message: "alertVideoMessage".localized(), actions: [okAction])
    }
    
    // MARK: - Private Methods
    private func setUpViewController() {
        title = "navigationInfoTitle".localized()
    }
}
