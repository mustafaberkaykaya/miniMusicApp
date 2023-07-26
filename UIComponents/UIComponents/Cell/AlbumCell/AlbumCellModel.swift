//
//  AlbumCellModel.swift
//  UIComponents
//
//  Created by FOREKS on 16.07.2023.
//

import Foundation
import UIKit

public protocol AlbumCellDataSource: AnyObject {
    var albumImageUrl: String? { get set }
    var albumNameText: String? { get set }
    var albumReleaseDayText: String? { get set }
}

public protocol AlbumCellEventSource: AnyObject {
    
}

public protocol AlbumCellProtocol: AlbumCellDataSource, AlbumCellEventSource {
    
}

public final class AlbumCellModel: AlbumCellProtocol {
    
    public var albumImageUrl: String?
    public var albumReleaseDayText: String?
    public var albumNameText: String?
    
    public init(albumImageUrl: String?, albumReleaseDayText: String?, albumNameText: String?) {
        self.albumImageUrl = albumImageUrl
        self.albumReleaseDayText = albumReleaseDayText
        self.albumNameText = albumNameText
    }
}
