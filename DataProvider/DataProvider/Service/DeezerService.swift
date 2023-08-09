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
    
    public func getArtist(id: Int, completion: @escaping (Result<Artist, NetworkError>) -> Void) {
        NetworkExecuter.shared.execute(route: DeezerAPI.artist(id: id), responseModel: Artist.self, completion: completion)
    }
    
    public func getAlbums(id: Int, completion: @escaping (Result<Album, NetworkError>) -> Void) {
        NetworkExecuter.shared.execute(route: DeezerAPI.album(id: id), responseModel: Album.self, completion: completion)
    }
    
    public func getTrackList(id: Int, completion: @escaping (Result<Tracks, NetworkError>) -> Void) {
        NetworkExecuter.shared.execute(route: DeezerAPI.trackList(id: id), responseModel: Tracks.self, completion: completion)
    }
}
