//
//  ArtistData.swift
//  DataProvider
//
//  Created by FOREKS on 8.07.2023.
//

import Foundation

public struct ArtistData: Decodable {
    public let id: Int?
    public let name: String?
    public let picture: String?
    public let pictureSmall: String?
    public let pictureMedium: String?
    public let pictureBig: String?
    public let pictureXl: String?
    public let type: String?
    public let radio: Bool?
    public let tracklist: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
        case type
        case radio
        case tracklist
    }
}
