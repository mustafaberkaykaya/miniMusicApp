//
//  ArtistRouter.swift
//  miniMusicApp
//
//  Created by FOREKS on 4.07.2023.
//

import UIKit
import DataProvider

final class ArtistsRouter {

    static func create(category: CategoriesData) -> ArtistsViewController {
        let musicRepository = MusicRepository(deezerService: app.service)
        let viewModel = ArtistsViewModel(category: category, musicRepository: musicRepository)
        let viewController = ArtistsViewController(viewModel: viewModel)
        viewModel.routeDelegate = viewController
        return viewController
    }
}
