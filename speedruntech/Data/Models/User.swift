//
//  User.swift
//  speedruntech
//
//  Created by Javier Morgaz García on 15/8/18.
//  Copyright © 2018 Javier Morgaz García. All rights reserved.
//

import Foundation

public struct User: JsonDecodable {
    
    struct Keys {
        static let userId           = "id"
        static let names            = "names"
        static let international    = "international"
    }
    
    public var userId: String    = ""
    public var name: String      = ""
    
    init(userId: String,
         name: String) {
        
        self.userId     = userId
        self.name       = name
    }
    
    // MARK: - JsonDecodable
    init?(jsonDictionary: JsonDictionary?) {
        
        guard let dictionary = jsonDictionary,
            let jsonId      = dictionary[Keys.userId] as? String
            else {
                return nil
        }
        
        var jsonName    = ""
        
        if let nameDictionary = dictionary[Keys.names] as? JsonDictionary {
            jsonName = nameDictionary[Keys.international] as? String ?? ""
        }
        
        self.init(userId: jsonId, name: jsonName)
    }
}
