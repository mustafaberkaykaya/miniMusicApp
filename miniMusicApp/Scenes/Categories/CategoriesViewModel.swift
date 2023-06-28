//
//  CategoriesViewModel.swift
//  miniMusicApp
//
//  Created by FOREKS on 27.06.2023.
//

import Foundation


protocol CategoriesDataSource {}

protocol CategoriesEventSource {
}

protocol CategoriesProtocol: CategoriesDataSource, CategoriesEventSource {}

final class CategoriesViewModel: BaseViewModel, CategoriesProtocol {

 

}
