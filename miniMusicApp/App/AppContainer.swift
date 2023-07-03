//
//  AppContainer.swift
//  miniMusicApp
//
//  Created by FOREKS on 27.06.2023.
//

import Foundation
import DataProvider

let app = AppContainer()

final class AppContainer {
    let router = AppRouter()
    let service: DeezerServiceProtocol = DeezerService()
}
