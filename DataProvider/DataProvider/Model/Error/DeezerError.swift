//
//  DeezerError.swift
//  DataProvider
//
//  Created by FOREKS on 1.07.2023.
//

import Foundation

public struct DeezerError: Decodable, Error {
    public let error: DeezerErrorData?
}

public struct DeezerErrorData: Decodable {
    public let type: String?
    public let message: String?
    public let code: Int?
}
