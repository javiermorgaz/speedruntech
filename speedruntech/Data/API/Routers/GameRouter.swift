//
//  GameRouter.swift
//  speedruntech
//
//  Created by Javier Morgaz García on 12/8/18.
//  Copyright © 2018 Javier Morgaz García. All rights reserved.
//

import Alamofire

enum GameRouter: URLRequestConvertible {
    
    case games(String)
    
    var method: Alamofire.HTTPMethod {
        
        switch self {
            case .games: return .get
        }
    }
    
    var path: String {
        
        switch self {
            case .games(let baseUrl): return "\(baseUrl)/games"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = URL(string: path)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        switch self {
        case .games(_):
            return try Alamofire.JSONEncoding.default.encode(urlRequest, with: nil)

        }
    }
}
