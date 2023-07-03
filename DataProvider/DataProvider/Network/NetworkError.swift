//
//  NetworkError.swift
//  DataProvider
//
//  Created by FOREKS on 30.06.2023.
//

import Foundation

public enum NetworkError : Error, LocalizedError{
    case invalidURL
    case request(statusCode : Int,data : Data?)
    case badRequest
    case decodeError
    case noInternet
    case noResponse
    case responseConvert
    case noData
}

