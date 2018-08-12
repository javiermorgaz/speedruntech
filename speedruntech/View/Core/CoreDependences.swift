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
        
        //CocoaLumberJack setup
        DDLog.add(DDASLLogger.sharedInstance, with:.debug)
    }
    
    lazy var restClient: RestClientInterface = RestClient(baseUrl: "https://www.speedrun.com/api/v1")
}
