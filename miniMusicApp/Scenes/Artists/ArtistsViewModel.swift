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

protocol ArtistsProtocol: ArtistsDataDource, ArtistsEventSource { }

final class ArtistsViewModel: BaseViewModel, ArtistsProtocol {
    
    // EventSource
    var reloadData: VoidClosure?
    
    // DataSource
    var numberOfItems: Int {
        return cellItems.count
     }
    var cellItems: [ArtistCellProtocol] = []
    
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
        guard let id = category.id else { return }
        musicRepository.getArtist(id: id) { result in
            switch result {
            case .success(let response):
                guard let data = response.data else { return }
                self.cellItems = data.map({ artist in
                    return ArtistCellModel(artistImageView: artist.pictureMedium, artistName: artist.name)
                })
                self.reloadData?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
