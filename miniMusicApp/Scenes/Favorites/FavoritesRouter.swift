//
//  FavoritesRouter.swift
//  miniMusicApp
//
//  Created by FOREKS on 29.06.2023.
//

import UIKit

final class FavoritesRouter {

    static func create() -> FavoritesViewController {
        let viewModel = FavoritesViewModel()
        let viewController = FavoritesViewController(viewModel: viewModel)
        return viewController
    }
}
