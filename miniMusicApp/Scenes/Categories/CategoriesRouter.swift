//
//  CategoriesRouter.swift
//  miniMusicApp
//
//  Created by FOREKS on 27.06.2023.
//

import UIKit

final class CategoriesRouter {

    static func create() -> CategoriesViewController {
        let viewModel = CategoriesViewModel()
        let viewController = CategoriesViewController(viewModel: viewModel)
        return viewController
    }
}
