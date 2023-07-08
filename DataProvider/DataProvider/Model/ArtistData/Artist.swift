//
//  Artist.swift
//  DataProvider
//
//  Created by FOREKS on 8.07.2023.
//

import Foundation

public struct Artist: Decodable {
    public let data: [ArtistData]?

    enum CodingKeys: String, CodingKey {
        case data
    }
}

