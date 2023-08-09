//
//  AlbumRouter.swift
//  miniMusicApp
//
//  Created by FOREKS on 26.07.2023.
//

import UIKit
import DataProvider

final class AlbumRouter {

    static func create(album: AlbumData) -> AlbumViewController {
        let musicRepository = MusicRepository(deezerService: app.service)
        let viewModel = AlbumViewModel(album: album, musicRepository: musicRepository)
        let viewController = AlbumViewController(viewModel: viewModel)
        return viewController
    }
}
