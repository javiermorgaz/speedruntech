//
//  Game.swift
//  speedruntech
//
//  Created by Javier Morgaz García on 12/8/18.
//  Copyright © 2018 Javier Morgaz García. All rights reserved.
//

import Foundation

public struct Games: ArrayJSONDecodable {
    
    public var games: [Game]
    
    // MARK: - ArrayJSONDecodable
    init?(array: [JsonDictionary]?) {
        guard let arrayDictionary = array
            else {
                return nil
        }
        self.games = decode(arrayDictionary)
    }
}

public struct Game : JsonDecodable {
 
    struct Keys {
        static let gameId           = "id"
        static let names            = "names"
        static let international    = "international"
        static let assets           = "assets"
        static let logo             = "logo"
        static let uri              = "uri"
    }
    
    public var gameId:String    = ""
    public var name:String      = ""
    public var logoUri:String   = ""
    
    init(gameId: String,
         name:String,
         logoUri:String) {
        
        self.gameId     = gameId
        self.name       = name
        self.logoUri    = logoUri
    }
    
    // MARK: - JsonDecodable
    init?(jsonDictionary: JsonDictionary?) {
        
        guard   let dictionary = jsonDictionary,
            let jsonId      = dictionary[Game.Keys.gameId] as? String
            else {
                return nil
        }
        
        var jsonName    = ""
        var jsonLogoUri = ""
        
        if let nameDictionary = dictionary[Game.Keys.names] as? JsonDictionary {
            jsonName = nameDictionary[Game.Keys.international] as? String ?? ""
        }
        
        if let assetsDictionary = dictionary[Game.Keys.assets] as? JsonDictionary,
            let logoDictionary = assetsDictionary[Game.Keys.logo] as? JsonDictionary{
            jsonLogoUri = logoDictionary[Game.Keys.uri] as? String ?? ""
        }

        self.init(gameId: jsonId, name: jsonName, logoUri: jsonLogoUri)
    }

}
