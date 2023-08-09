//
//  TracksData.swift
//  DataProvider
//
//  Created by FOREKS on 4.08.2023.
//

import Foundation

public struct TracksData: Decodable {
    public let data: [TrackListData]?

    enum CodingKeys: String, CodingKey {
        case data
    }
}

public struct TrackListData: Decodable {
    public let id: Int?
    public let title: String?
    public let duration: Int?
    public let preview: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case duration
        case preview
    }
}
