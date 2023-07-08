//
//  MusicRepositoryProtocol.swift
//  DataProvider
//
//  Created by FOREKS on 1.07.2023.
//

import Foundation

public protocol MusicRepositoryProtocol {
    func getCategories(completion: @escaping(Result<Categories,DeezerError>) -> Void)
    func getArtist(id: Int, completion: @escaping(Result<Artist,DeezerError>) -> Void)
}
