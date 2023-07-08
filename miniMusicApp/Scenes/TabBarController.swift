//
//  TabBarController.swift
//  miniMusicApp
//
//  Created by FOREKS on 30.06.2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVCs()
    }
    
    func setupVCs() {
          viewControllers = [
            createNavController(for: CategoriesRouter.create(), title: NSLocalizedString("Categories", comment: ""), image: UIImage(systemName: "music.mic")!),
            createNavController(for: FavoritesRouter.create(), title: NSLocalizedString("Favorites", comment: ""), image: UIImage(systemName: "heart")!)
          ]
      }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage) -> UIViewController {
          let navController = UINavigationController(rootViewController: rootViewController)
          navController.tabBarItem.image = image
          return navController
      }
}

