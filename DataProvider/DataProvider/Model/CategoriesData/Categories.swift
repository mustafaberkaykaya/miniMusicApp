//
//  Categories.swift
//  DataProvider
//
//  Created by FOREKS on 1.07.2023.
//

import Foundation

public struct Categories: Decodable {
    public let data: [CategoriesData]?

    enum CodingKeys: String, CodingKey {
        case data 
    }
}
