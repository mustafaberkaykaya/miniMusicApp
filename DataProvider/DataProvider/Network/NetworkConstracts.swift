//
//  NetworkConstracts.swift
//  DataProvider
//
//  Created by FOREKS on 30.06.2023.
//

import Foundation
import UIKit

public protocol BaseClientGenerator {
    var scheme : String { get }
    var host : String { get }
    var path : String { get }
    var queryItems : [URLQueryItem]? { get }
    var method : HttpMethod { get }
    var header : [HttpHeader]? { get }
    var body : [String : Any]? { get }
}

public extension BaseClientGenerator {
    func asURLRequest() throws -> URLRequest {
        var urlComponent = URLComponents()
        
        //MARK: - Components
        urlComponent.scheme = scheme
        urlComponent.host = host
        urlComponent.path = path
        urlComponent.queryItems = queryItems
        
        //MARK: - URLRequest
        var request = URLRequest(url: urlComponent.url!)
        
        //MARK: - Method
        request.httpMethod = method.rawValue
        
        //MARK: - Header
        if let httpHeader = header {
            httpHeader.forEach { httpValues in
                request.setValue(httpValues.value, forHTTPHeaderField: httpValues.key)
            }
        }
        
        //MARK: - Body
        if let httpBody = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: httpBody, options: [])
        }
        return request
    }
}
