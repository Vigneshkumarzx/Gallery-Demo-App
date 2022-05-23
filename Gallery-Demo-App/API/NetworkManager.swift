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
        
       
        urlRequest.addValue(AppConstants.ACCESS_TOKEN, forHTTPHeaderField: "Authorization")
        NetworkManager.sharedManager.request(urlRequest).responseData { (response) in
            
            if let statusCode = response.response?.statusCode {
                switch statusCode {
                case APIStatusCode.success.rawValue:
                    if let responseData = response.data {
                        success(responseData, statusCode)
                    }
                default:
                    failed(response.error, statusCode)
                }
            }
        }
    }
    
    static func put(_ url: String,
                    token: String,
                    requestBody: Parameters,
                    encoding: ParameterEncoding = URLEncoding.default,
                    success: @escaping(_ response: Data?, _ statusCode: Int) -> Void,
                    failed: @escaping(_ error: Error?, _ statusCode: Int) -> Void) {
        
        let accessToken = "Bearer " + token
        let header: HTTPHeaders = ["Authorization": accessToken]
        
        NetworkManager.sharedManager.request(url,
                                             method: .put,
                                             parameters: requestBody,
                                             encoding: encoding,
                                             headers: header).responseJSON { (response) in
            
            if let statusCode = response.response?.statusCode {
                switch statusCode {
                case APIStatusCode.success.rawValue:
                    if let responseData = response.data {
                        success(responseData, statusCode)
                    }
                case APIStatusCode.badRequest.rawValue:
                    if let responseData = response.data {
                        success(responseData, statusCode)
                    }
                default:
                    failed(response.error, statusCode)
                }
            }
        }
    }
    
    static func delete(_ url: String,
                       token: String,
                       success: @escaping(_ response: Data?, _ statusCode: Int) -> Void,
                       failed: @escaping(_ error: Error?, _ statusCode: Int) -> Void) {
        
        guard let url = URL(string: url) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.delete.rawValue
    
        urlRequest.addValue(AppConstants.ACCESS_TOKEN, forHTTPHeaderField: "Authorization")
        
        NetworkManager.sharedManager.request(urlRequest).responseJSON { (response) in
            
            if let statusCode = response.response?.statusCode {
                switch statusCode {
                case APIStatusCode.success.rawValue:
                    success(response.data, statusCode)
                default:
                    failed(response.error, statusCode)
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
