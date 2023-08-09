//
//  ArtistDetailRouter.swift
//  miniMusicApp
//
//  Created by FOREKS on 8.07.2023.
//

import UIKit
import DataProvider

final class ArtistDetailRouter {

    static func create(artists: ArtistData) -> ArtistDetailViewController {
        let musicRepository = MusicRepository(deezerService: app.service)
        let viewModel = ArtistDetailViewModel(artists: artists, musicRepository: musicRepository)
        let viewController = ArtistDetailViewController(viewModel: viewModel)
        viewModel.routeDelegate = viewController
        return viewController
    }
}
