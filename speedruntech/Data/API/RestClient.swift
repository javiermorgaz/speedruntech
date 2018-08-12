//
//  RestClient.swift
//  speedruntech
//
//  Created by Javier Morgaz García on 11/8/18.
//  Copyright © 2018 Javier Morgaz García. All rights reserved.
//

import Foundation
import Alamofire
import CocoaLumberjack

public protocol RestClientInterface: class {
    
    var baseUrl: String { get }
    
    func perform<R:URLRequestConvertible>(request: R,
                 success succeed : @escaping ((Any) -> Void),
                 failure failed : @escaping (() -> Void))
}

class RestClient: RestClientInterface {
    
    let baseUrl: String
    
    public init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func perform<R:URLRequestConvertible>(request: R,
                                          success: @escaping ((Any) -> Void),
                                          failure: @escaping (() -> Void)) {
        
        print(request: request)
        
        Alamofire.request(request).validate(statusCode: 200..<401).responseJSON { response in
            
            switch response.result {
            case .success:
                
                self.print(response: response)
                if let resultValue = response.result.value as? JsonDictionary,
                    let restResponse = RestResponse(jsonDictionary: resultValue) {
                    success(restResponse.result as Any)
                    
                } else {
                    self.printParsingError(response: response)
                    failure()
                }
                
            case .failure( _ ):
                
                self.printError(response: response)
                failure()
            }
        }
    }
    
    func print<R:URLRequestConvertible>(request:R) {
        
        DDLogInfo("\n🔻 ↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️")
        DDLogInfo("Starting Request...")
        if let method = request.urlRequest?.httpMethod {
            DDLogInfo("Method: \(String(describing: method))")
            
        }
        if let url = request.urlRequest?.url {
            DDLogInfo("URL: \(String(describing: url))")
            
        }
        if let headers = request.urlRequest?.allHTTPHeaderFields {
            DDLogInfo("Headers: \(String(describing: headers))")
            
        }
        if let body = request.urlRequest?.httpBody {
            DDLogInfo("Body: \(String(data: body, encoding: .utf8)!)")
            
        }
        DDLogInfo("\n↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️ 🔺\n")
    }

    func print(response: DataResponse<Any>) {
        DDLogInfo("\n🔻 ✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅")
        DDLogInfo("Response:")
        DDLogInfo("\(response.debugDescription)")
        DDLogInfo("\n✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅ 🔺\n")
    }
    
    func printError(response: DataResponse<Any>) {
        DDLogError("\n🔻 ❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌")
        DDLogError("Response:")
        DDLogError("\n\(response.debugDescription)")
        DDLogError("\n❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌ 🔺\n")
    }
    
    
    func printParsingError(response: DataResponse<Any>) {
        DDLogError("\n🔻 ❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌")
        DDLogError("PARSING RESPONSE ERROR")
        DDLogError("\nResponse:")
        DDLogError("\n\(response.debugDescription)")
        DDLogError("\n❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌ 🔺\n")
    }

}
