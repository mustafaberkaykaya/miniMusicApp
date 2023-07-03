//
//  MusicRepository.swift
//  DataProvider
//
//  Created by FOREKS on 1.07.2023.
//

import Foundation

final public class MusicRepository: MusicRepositoryProtocol {
    
    private var deezerService: DeezerServiceProtocol
    
    //MARK: - Inject DeezerServiceProtocol
    public init(deezerService : DeezerServiceProtocol) {
        self.deezerService = deezerService
    }
    
    public func getCategories(completion: @escaping (Result<Categories, DeezerError>) -> Void) {
        deezerService.getCategories { result in
            switch result {
            case .success(let getCategoriesResponse):
                return completion(.success(getCategoriesResponse))
            case .failure(let error):
                let deezerErrorData = DeezerErrorData(type: nil, message: error.localizedDescription, code: nil)
                let deezerError = DeezerError(error: deezerErrorData)
                return completion(.failure(deezerError))
            }
        }
    }
    
}
