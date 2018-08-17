//
//  AppEnvironment.swift
//  speedruntech
//
//  Created by Javier Morgaz García on 17/8/18.
//  Copyright © 2018 Javier Morgaz García. All rights reserved.
//

import Foundation
import UIKit
import CocoaLumberjack

enum Environment: String {
    
    case debug      = "Debug"
    case production = "Release"
    
    var baseURL: String {
        switch self {
        case .debug: return "https://www.speedrun.com/api/v1"
        case .production: return "https://www.speedrun.com/api/v1"
        }
    }
}

class AppEnvironment {
    
    static var environment: Environment = {
        if let configuration = Bundle.main.infoDictionary?["Configuration"] as? String {
            guard let environmentConfiguration = Environment(rawValue: configuration) else {
                DDLogError("No Environment")
                return .debug
            }
            return environmentConfiguration
        }
        DDLogError("No Environment")
        return .debug
    }()
}
