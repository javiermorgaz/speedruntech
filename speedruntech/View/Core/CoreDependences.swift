//
//  CoreDependences.swift
//  speedruntech
//
//  Created by Javier Morgaz García on 11/8/18.
//  Copyright © 2018 Javier Morgaz García. All rights reserved.
//

import Foundation
import CocoaLumberjack

class CoreDependences {
    
    public static let sharedInstance = CoreDependences()
    
    private init() {
        
        //CocoaLumberJack Setup
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            DDLog.add(DDASLLogger.sharedInstance, with: .off)
        } else {
            DDLog.add(DDASLLogger.sharedInstance, with: .debug)
        }
    }
    
    lazy var restClient: RestClientInterface = RestClient(baseUrl: AppEnvironment.environment.baseURL)
}
