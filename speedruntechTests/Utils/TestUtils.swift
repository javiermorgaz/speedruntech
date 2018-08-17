//
//  TestUtils.swift
//  speedruntechTests
//
//  Created by Javier Morgaz García on 17/8/18.
//  Copyright © 2018 Javier Morgaz García. All rights reserved.
//

import Foundation
@testable import speedruntech

class TestUtils {
    
    public static func jsonModel(withName name: String) -> JsonDictionary? {
        
        let bundle = Bundle(for: self)
        guard
            let filePath = bundle.path(forResource: name, ofType: "json", inDirectory: "Mocks/Json/Model"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: filePath), options: .alwaysMapped),
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            else {
                print("JSON FILE ERROR")
                return nil
        }
        return json as? JsonDictionary
    }
}
