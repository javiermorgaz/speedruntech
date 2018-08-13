//
//  String.swift
//  speedruntech
//
//  Created by Javier Morgaz García on 13/8/18.
//  Copyright © 2018 Javier Morgaz García. All rights reserved.
//

import Foundation

extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
}
