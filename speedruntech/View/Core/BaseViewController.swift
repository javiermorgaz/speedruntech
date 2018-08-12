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

class BaseViewController: UIViewController {

    var loadingActivity:MBProgressHUD?
    
    required init?(coder aDecoder: NSCoder) { //THIS PREVENTS THAT WHEN A BASEVIEWCONTROLLER IS NOT CREATED FROM STORYBOARD
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewControllerName = "VIEWCONTROLLER:" + String(describing: self)
        DDLogInfo(viewControllerName)
    }
    
    // MARK: - Public
    public func setTitle(title:String) {
        navigationItem.titleView = nil
        self.title = title
    }
    
    public func presentLoadingNotificationIn(view: UIView, isUserInteractionEnabled:Bool) {
        
        removeLoadingNotification()
        let loadingActivity = MBProgressHUD.showAdded(to: view, animated: true)
        loadingActivity.removeFromSuperViewOnHide = true
        loadingActivity.bezelView.backgroundColor = UIColor.clear
        loadingActivity.bezelView.color = UIColor.clear
        loadingActivity.bezelView.style = .solidColor
        loadingActivity.isUserInteractionEnabled = isUserInteractionEnabled
        isUserInteractionEnabled ? UIApplication.shared.beginIgnoringInteractionEvents() :
            UIApplication.shared.endIgnoringInteractionEvents()
        
        self.loadingActivity = loadingActivity
    }
    
    public func removeLoadingNotification() {
        
        if let _loadingActivity = loadingActivity {
            _loadingActivity.hide(animated: true)
        }
        UIApplication.shared.endIgnoringInteractionEvents()
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
