//
//  CategoriesViewModel.swift
//  miniMusicApp
//
//  Created by FOREKS on 27.06.2023.
//

import Foundation
import DataProvider
import UIComponents

protocol CategoriesDataSource {
    var numberOfItems: Int { get }
    func cellForItemAt(indexPath: IndexPath) -> CategoriesCellProtocol
}

protocol CategoriesEventSource {
    var reloadData: VoidClosure? { get set }
}

protocol CategoriesProtocol: CategoriesDataSource, CategoriesEventSource {
    func didLoad()
    func didSelectItem(indexPath: IndexPath)
}

protocol CategoriesRouteDelegate: AnyObject {
    func showArtist(category: CategoriesData)
}

final class CategoriesViewModel: BaseViewModel, CategoriesProtocol {
    
    // EventSource
    var reloadData: VoidClosure?
    weak var routeDelegate: CategoriesRouteDelegate?
    
    // DataSource
    var musicRepository: MusicRepositoryProtocol
    var numberOfItems: Int {
       return cellItems.count
    }
    var cellItems: [CategoriesCellProtocol] = []
    var categories: [CategoriesData] = []
    
    func cellForItemAt(indexPath: IndexPath) -> CategoriesCellProtocol {
      return cellItems[indexPath.row]
    }
    
    init(musicRepository: MusicRepositoryProtocol) {
        self.musicRepository = musicRepository
    }
    
    func didLoad() {
        musicRepository.getCategories { result in
            switch result {
            case .success(let response):
                guard let data = response.data else { return }
                self.categories = data
                self.cellItems = data.map({ category in
                    return CategoriesCellModel(categoryImageView: category.pictureMedium, categoryName: category.name)
                })
                self.reloadData?()
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}

// MARK: - Action
extension CategoriesViewModel {
    func didSelectItem(indexPath: IndexPath) {
        let category = categories[indexPath.row]
        routeDelegate?.showArtist(category: category)
    }
}

