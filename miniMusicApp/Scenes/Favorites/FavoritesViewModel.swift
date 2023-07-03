//
//  FavoritesViewModel.swift
//  miniMusicApp
//
//  Created by FOREKS on 29.06.2023.
//

protocol FavoritesDataSource {}

protocol FavoritesEventSource {
}

protocol FavoritesProtocol: FavoritesDataSource, FavoritesEventSource {}

final class FavoritesViewModel: BaseViewModel, FavoritesProtocol {


}
