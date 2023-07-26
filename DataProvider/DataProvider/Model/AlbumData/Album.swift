//
//  Album.swift
//  DataProvider
//
//  Created by FOREKS on 22.07.2023.
//

import Foundation

public struct Album: Decodable {
    public let data: [AlbumData]?
    public let total: Int?
    public let next: String?

    enum CodingKeys: String, CodingKey {
        case data
        case total
        case next
    }
}


