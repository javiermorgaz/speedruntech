//
//  BaseViewController.swift
//  speedruntech
//
//  Created by Javier Morgaz García on 11/8/18.
//  Copyright © 2018 Javier Morgaz García. All rights reserved.
//

import UIKit
import MBProgressHUD
import CocoaLumberjack

public protocol BaseViewControllerInterface {
    func presentLoadingNotification()
    func removeLoadingNotification()
}

class BaseViewController: UIViewController, BaseViewControllerInterface {

    private var loadingActivity: MBProgressHUD?
    
    required init?(coder aDecoder: NSCoder) { //THIS PREVENTS THAT WHEN A BASEVIEWCONTROLLER IS NOT CREATED FROM STORYBOARD
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewControllerName = "VIEWCONTROLLER:" + String(describing: self)
        DDLogInfo(viewControllerName)
    }
    
    // MARK: - Public
    public func setTitle(title: String) {
        navigationItem.titleView = nil
        self.title = title
    }
    
    public func presentLoadingNotification() {
        
        removeLoadingNotification()
        
        DispatchQueue.main.async {
            
            let loadingActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
            loadingActivity.removeFromSuperViewOnHide = true
            loadingActivity.bezelView.backgroundColor = UIColor.clear
            loadingActivity.bezelView.color = UIColor.clear
            loadingActivity.bezelView.style = .solidColor
            
            self.loadingActivity = loadingActivity
        }
    }
    
    public func removeLoadingNotification() {
        
        DispatchQueue.main.async {
            if let loadingActivity = self.loadingActivity {
                loadingActivity.hide(animated: true)
            }
        }
    }
    
    public func showAlert(title: String?, message: String, actions: [UIAlertAction]) {
        removeLoadingNotification()
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for action in actions {
            alert.addAction(action)
        }
        
        present(alert, animated: true)
    }
}
