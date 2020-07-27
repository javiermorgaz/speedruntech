//
//  GameRouter.swift
//  speedruntech
//
//  Created by Javier Morgaz García on 12/8/18.
//  Copyright © 2018 Javier Morgaz García. All rights reserved.
//

import Alamofire

enum GameRouter: URLRequestConvertible {
    
    case games(baseUrl: String)
    case runs(baseUrl: String, gameId: String)
    case users(baseUrl: String, userId: String)
    
    struct RouterKeys {
        static let game = "game"
    }
    
    var method: Alamofire.HTTPMethod {
        
        switch self {
        case .games: return .get
        case .runs: return .get
        case .users: return .get
        }
    }
    
    var path: String {
        
        switch self {
        case .games(let baseUrl): return "\(baseUrl)/games"
        case .runs(let baseUrl, _): return "\(baseUrl)/runs"
        case .users(let baseUrl, let userId): return "\(baseUrl)/users/\(userId)"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = URL(string: path)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        switch self {
        case .games: return try Alamofire.URLEncoding.default.encode(urlRequest, with: nil)
        case .runs(_, let gameId):
            let params: Parameters = [RouterKeys.game: gameId]
            return try Alamofire.URLEncoding.queryString.encode(urlRequest, with: params)
        case .users: return try Alamofire.URLEncoding.default.encode(urlRequest, with: nil)
        }
    }
}
