//
//  JsonDecodable.swift
//  speedruntech
//
//  Created by Javier Morgaz García on 12/8/18.
//  Copyright © 2018 Javier Morgaz García. All rights reserved.
//

import Foundation

typealias JsonDictionary = [String: AnyObject]

protocol JsonDecodable {
    init?(jsonDictionary: JsonDictionary?)
}

protocol ArrayJSONDecodable {
    init?(array: [JsonDictionary]?)
}

func decode<T: JsonDecodable>(_ dictionaries: [JsonDictionary]) -> [T] {
    return dictionaries.compactMap { T(jsonDictionary: $0) }
}

func decode<T: JsonDecodable>(_ dictionary: JsonDictionary) -> T? {
    return T(jsonDictionary: dictionary)
}

func decode<T:JsonDecodable>(_ data: Data) -> [T]? {
    guard let JSONObject = try? JSONSerialization.jsonObject(with: data, options: []),
        let dictionaries = JSONObject as? [JsonDictionary] else { return nil }
    let objects: [T] = decode(dictionaries)
    return objects
}
