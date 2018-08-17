//
//  RestClientStub.swift
//  speedruntechTests
//
//  Created by Javier Morgaz García on 16/8/18.
//  Copyright © 2018 Javier Morgaz García. All rights reserved.
//

import Foundation
@testable import speedruntech

protocol RestClientStubInterface: RestClientInterface {
    
    var mockPath: String { get set }
}

public class RestClientStub: RestClient, RestClientStubInterface {
    
    public var mockPath: String = "" {
        didSet {
            baseUrl = "\(baseUrl)\(mockPath)"
        }
    }
}
