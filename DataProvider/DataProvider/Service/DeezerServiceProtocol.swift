//
//  DeezerServiceProtocol.swift
//  DataProvider
//
//  Created by FOREKS on 1.07.2023.
//

import Foundation

public protocol DeezerServiceProtocol {
    func getCategories(completion: @escaping (Result<Categories, NetworkError>) -> Void)
}
