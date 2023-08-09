//
//  Tracks.swift
//  DataProvider
//
//  Created by FOREKS on 3.08.2023.
//

import Foundation

public struct Tracks: Decodable {
    public let id: Int?
    public let title: String?
    public let coverMedium: String?
    public let tracks: TracksData?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case coverMedium = "cover_medium"
        case tracks
    }
}

