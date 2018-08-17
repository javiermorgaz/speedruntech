//
//  RestResponse.swift
//  speedruntech
//
//  Created by Javier Morgaz García on 12/8/18.
//  Copyright © 2018 Javier Morgaz García. All rights reserved.
//

import Foundation

public struct RestResponse: JsonDecodable {
    
    struct Keys {
        static let data = "data"
    }
    
    var result: Any?
    
    init?(jsonDictionary: JsonDictionary?) {
        guard let dictionary = jsonDictionary,
            let data = dictionary[Keys.data]
            else {
                return nil
        }
        
        self.result = data
    }

}
