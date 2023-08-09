//
//  ArtistDetailViewModel.swift
//  miniMusicApp
//
//  Created by FOREKS on 8.07.2023.
//

import Foundation
import DataProvider
import UIComponents

protocol ArtistDetailDataSource {
    func cellForArtistCoverItemAt() -> ArtistCoverImageCellProtocol
    func cellForAlbumInfosItemAt(indexPath: IndexPath) -> AlbumCellProtocol
}

protocol ArtistDetailEventSource {
    var reloadData: VoidClosure? { get set }
}

protocol ArtistDetailProtocol: ArtistDetailDataSource, ArtistDetailEventSource {
    func didLoad()
    func didSelectItem(indexPath: IndexPath)
}

protocol ArtistsDetailRouteDelegate: AnyObject {
    func showAlbum(album: AlbumData)
}

final class ArtistDetailViewModel: BaseViewModel, ArtistDetailProtocol {
 
    //EventSource
    var reloadData: VoidClosure?
    weak var routeDelegate: ArtistsDetailRouteDelegate?
    
    //Data Source
    var artists: ArtistData
    var albumData: [AlbumData] = []
    var musicRepository: MusicRepositoryProtocol
    var cellItems: [AlbumCellProtocol] = []
    
    var numberOfItems: Int {
        return cellItems.count
     }
    
    func cellForArtistCoverItemAt() -> ArtistCoverImageCellProtocol {
        return ArtistCoverImageCellModel(artistImageView: artists.pictureBig)
    }
    
    func cellForAlbumInfosItemAt(indexPath: IndexPath) -> AlbumCellProtocol {
        return cellItems[indexPath.row]
    }
    
    init(artists: ArtistData, musicRepository: MusicRepositoryProtocol) {
        self.artists = artists
        self.musicRepository = musicRepository
    }
    
    func didLoad() {
        showLoading?()
        guard let id = artists.id else { return }
        musicRepository.getAlbums(id: id) { result in
            switch result {
            case .success(let response):
                guard let data = response.data else { return }
                self.albumData = data
                self.cellItems = data.map({ album in
                    return AlbumCellModel(albumImageUrl: album.coverMedium, albumReleaseDayText: album.releaseDate, albumNameText: album.title)
                })
                self.reloadData?()
                self.hideLoading?()
            case .failure(let err):
                print(err.localizedDescription)
                self.hideLoading?()
            }
        }
    }
}

// MARK: - Action
extension ArtistDetailViewModel {
    func didSelectItem(indexPath: IndexPath) {
         let album = albumData[indexPath.row]
         routeDelegate?.showAlbum(album: album)
    }
}

