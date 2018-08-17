//
//  Run.swift
//  speedruntech
//
//  Created by Javier Morgaz García on 15/8/18.
//  Copyright © 2018 Javier Morgaz García. All rights reserved.
//

import Foundation

public struct Runs: ArrayJSONDecodable {
    
    public var runs: [Run]
    
    // MARK: - ArrayJSONDecodable
    init?(array: [JsonDictionary]?) {
        guard let arrayDictionary = array
            else {
                return nil
        }
        self.runs = decode(arrayDictionary)
    }
}

public struct Run: JsonDecodable {
    
    struct Keys {
        static let valueId = "id"
        static let players = "players"
        static let name    = "name"
        static let videos  = "videos"
        static let links   = "links"
        static let uri     = "uri"
        static let times   = "times"
        static let primary = "primary"
    }
    
    public var runId: String       = ""
    public var playerId: String?
    public var playerName: String?
    public var time: String        = ""
    public var videoUri: String    = ""
    
    init(runId: String,
         playerId: String?,
         playerName: String?,
         time: String,
         videoUri: String) {
        
        self.runId      = runId
        self.playerId   = playerId
        self.playerName = playerName
        self.time       = time
        self.videoUri   = videoUri
    }
    
    // MARK: - JsonDecodable
    init?(jsonDictionary: JsonDictionary?) {
        
        guard let dictionary = jsonDictionary,
            let jsonId      = dictionary[Keys.valueId] as? String
            else {
                return nil
        }
        
        var jsonTime       = ""
        var jsonPlayerId: String?
        var jsonPlayerName: String?
        var jsonVideoUri   = ""
        
        if let timesDictionary = dictionary[Keys.times] as? JsonDictionary {
            jsonTime = timesDictionary[Keys.primary] as? String ?? ""
        }
        
        if let playersArray = dictionary[Keys.players] as? [JsonDictionary],
            let playerDictionary = playersArray.first {
            jsonPlayerId = playerDictionary[Keys.valueId] as? String
            jsonPlayerName = playerDictionary[Keys.name] as? String
        }
        
        if let videosDictionary = dictionary[Keys.videos] as? JsonDictionary,
            let uriArray = videosDictionary[Keys.links] as? [JsonDictionary],
            let uriDictionary = uriArray.first {
            jsonVideoUri = uriDictionary[Keys.uri] as? String ?? ""
        }
        
        self.init(runId: jsonId, playerId: jsonPlayerId, playerName: jsonPlayerName, time: jsonTime, videoUri: jsonVideoUri)
    }
}
