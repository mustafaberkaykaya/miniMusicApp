//
//  AppRouter.swift
//  miniMusicApp
//
//  Created by FOREKS on 27.06.2023.
//

import UIKit

final class AppRouter {

    var window: UIWindow?

    init() {}
 
    func startApplication() {
        guard let window = window else { fatalError("Window value cannot be nil") }
        let viewController = ViewController()
        window.rootViewController = viewController
    }
}
