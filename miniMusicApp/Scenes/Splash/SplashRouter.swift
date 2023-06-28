//
//  SplashRouter.swift
//  miniMusicApp
//
//  Created by FOREKS on 27.06.2023.
//

final class SplashRouter {
    
    static func create() -> SplashViewController {
        let viewModel = SplashViewModel()
        let viewController = SplashViewController(viewModel: viewModel)
        viewModel.routeDelegate = viewController
        return viewController
    }
}
