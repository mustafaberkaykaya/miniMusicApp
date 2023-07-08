//
//  CategoriesRouter.swift
//  miniMusicApp
//
//  Created by FOREKS on 27.06.2023.
//

import UIKit
import DataProvider

final class CategoriesRouter {

    static func create() -> CategoriesViewController {
        let musicRepository = MusicRepository(deezerService: app.service)
        let viewModel = CategoriesViewModel(musicRepository: musicRepository)
        let viewController = CategoriesViewController(viewModel: viewModel)
        viewModel.routeDelegate = viewController
        return viewController
    }
}
