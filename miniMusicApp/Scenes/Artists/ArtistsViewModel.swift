//
//  ArtistsViewModel.swift
//  miniMusicApp
//
//  Created by FOREKS on 4.07.2023.
//

import Foundation
import UIComponents
import DataProvider

protocol ArtistsDataDource {
    var numberOfItems: Int { get }
    func cellForItemAt(indexPath: IndexPath) -> ArtistCellProtocol
}

protocol ArtistsEventSource {
    var reloadData: VoidClosure? { get set }

}

protocol ArtistsRouteDelegate: AnyObject {
    func showArtistDetail(artist: ArtistData)
}

protocol ArtistsProtocol: ArtistsDataDource, ArtistsEventSource {
    func didSelectItem(indexPath: IndexPath)
}

final class ArtistsViewModel: BaseViewModel, ArtistsProtocol {
    
    // EventSource
    var reloadData: VoidClosure?
    weak var routeDelegate: ArtistsRouteDelegate?
    
    // DataSource
    var numberOfItems: Int {
        return cellItems.count
     }
    var cellItems: [ArtistCellProtocol] = []
    var artistsData: [ArtistData] = []
    
    
    func cellForItemAt(indexPath: IndexPath) -> ArtistCellProtocol {
      return cellItems[indexPath.row]
    }

    var musicRepository: MusicRepositoryProtocol
    
    var category: CategoriesData
    
    init(category: CategoriesData, musicRepository: MusicRepositoryProtocol) {
        self.category = category
        self.musicRepository = musicRepository
    }
    
    func didLoad() {
        showLoading?()
        guard let id = category.id else { return }
        musicRepository.getArtist(id: id) { result in
            switch result {
            case .success(let response):
                guard let data = response.data else { return }
                self.artistsData = data
                self.cellItems = data.map({ artist in
                    return ArtistCellModel(artistImageView: artist.pictureMedium, artistName: artist.name)
                })
                self.reloadData?()
                self.hideLoading?()
            case .failure(let error):
                print(error.localizedDescription)
                self.hideLoading?()
            }
        }
    }
}

// MARK: - Action
extension ArtistsViewModel {
    func didSelectItem(indexPath: IndexPath) {
        let artist = artistsData[indexPath.row]
        routeDelegate?.showArtistDetail(artist: artist)
    }
}
