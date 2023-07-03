//
//  DeezerService.swift
//  DataProvider
//
//  Created by FOREKS on 1.07.2023.
//

import Foundation

final public class DeezerService: DeezerServiceProtocol {
    
    public init() {
        
    }
    
    public func getCategories(completion: @escaping (Result<Categories, NetworkError>) -> Void) {
        NetworkExecuter.shared.execute(route: DeezerAPI.categories, responseModel: Categories.self, completion: completion)
    }
}
