//
//  DeezerClient.swift
//  DataProvider
//
//  Created by FOREKS on 1.07.2023.
//

import Foundation

public enum DeezerAPI : BaseClientGenerator {
    
    // MARK: - Requests
    case categories
    
    public var scheme: String { "https" }
    
    public var host: String { "api.deezer.com" }
    
    // MARK: - PATH
    public var path: String {
        switch self {
        case .categories:
            return "/genre"
        }
    }
    
    //MARK: - Query Items
    public var queryItems: [URLQueryItem]?{
        var items: [URLQueryItem] = []
        switch self {
        case .categories:
            break
        }
        return items
    }
    
    //MARK: - Default GET
    public var method: HttpMethod{
        switch self {
        default:
            return .get
        }
    }
    
    // MARK: - HEADER
    public var header: [HttpHeader]? {
        return [
            .contentType(),
        ]
    }
    
    //MARK: - Default Nil
    public var body: [String : Any]? {
        switch self {
        default:
            return nil
        }
    }
}

