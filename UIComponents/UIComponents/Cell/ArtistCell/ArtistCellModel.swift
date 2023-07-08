//
//  ArtistCellModel.swift
//  UIComponents
//
//  Created by FOREKS on 4.07.2023.
//

import Foundation
import UIKit

public protocol ArtistCellDataSource: AnyObject {
    var artistImageView: String? { get set }
    var artistName: String? { get set }
}

public protocol ArtistCellEventSource: AnyObject {
    
}

public protocol ArtistCellProtocol: ArtistCellDataSource, ArtistCellEventSource {
    
}

public final class ArtistCellModel: ArtistCellProtocol {
    
    public var artistImageView: String?
    public var artistName: String?
    
    public init(artistImageView: String?, artistName: String?) {
        self.artistImageView = artistImageView
        self.artistName = artistName
    }
}

