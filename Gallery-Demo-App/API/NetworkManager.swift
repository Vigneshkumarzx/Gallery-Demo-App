//
//  NetworkManager.swift
//  QuikchargeMobile
//
//  Created by vignesh kumar c on 17/05/22.
//

import Foundation
import Alamofire

struct NetworkManager {
    static var sharedManager: Session = setDefaultConfig()
    
    static func setDefaultConfig(maximumConnection: Int = 10, timeIntervalForRequest: TimeInterval = 60) -> Session {
        let manager = Alamofire.Session(configuration: URLSessionConfiguration.default)
        manager.session.configuration.httpMaximumConnectionsPerHost = maximumConnection
        manager.session.configuration.timeoutIntervalForRequest = timeIntervalForRequest
        return manager
    }
    static func get(_ url: String,
                    success: @escaping(_ response: Data?, _ statusCode: Int) -> Void,
                    failed: @escaping(_ error: Error?, _ statusCode: Int) -> Void) {
        
        guard let url = URL(string: url) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        
        urlRequest.timeoutInterval = 10
        urlRequest.addValue(AppConstants.ACCESS_TOKEN, forHTTPHeaderField: "Authorization")
        NetworkManager.sharedManager.request(urlRequest).responseData { (response) in
            if let statusCode = response.response?.statusCode {
                switch statusCode {
                case APIStatusCode.success.rawValue:
                    if let responseData = response.data {
                        success(responseData, statusCode)
                    } else {
                        failed(APIResponseError.badRequest, statusCode)
                    }
                default:
                    failed(APIResponseError.badRequest, statusCode)
                }
            }
        }
    }
}

enum APIStatusCode: Int {
    case success = 200
    case badRequest = 400
    case invalidRequest = 501
}

enum APIResponseError: Error {
    case serverInvalidResponse
    case badRequest
    case network
    case decoding
    case invalid
}
