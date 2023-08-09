//
//  DeezerServiceProtocol.swift
//  DataProvider
//
//  Created by FOREKS on 1.07.2023.
//

import Foundation

public protocol DeezerServiceProtocol {
    func getCategories(completion: @escaping (Result<Categories, NetworkError>) -> Void)
    func getArtist(id: Int, completion: @escaping(Result<Artist, NetworkError>) -> Void)
    func getAlbums(id: Int, completion: @escaping(Result<Album, NetworkError>) -> Void)
    func getTrackList(id: Int, completion: @escaping(Result<Tracks, NetworkError>) -> Void)
}
