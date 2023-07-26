//
//  AlbumData.swift
//  DataProvider
//
//  Created by FOREKS on 22.07.2023.
//

import Foundation

public struct AlbumData: Decodable {
    public let id: Int?
    public let title: String?
    public let link: String?
    public let cover: String?
    public let coverSmall: String?
    public let coverMedium: String?
    public let coverBig: String?
    public let coverXl: String?
    public let releaseDate: String?
    public let tracklist: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case link
        case cover
        case coverSmall = "cover_small"
        case coverMedium = "cover_medium"
        case coverBig = "cover_big"
        case coverXl = "cover_xl"
        case releaseDate = "release_date"
        case tracklist
    }
}

