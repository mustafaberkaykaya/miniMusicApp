//
//  ArtistCoverImageCellModel.swift
//  UIComponents
//
//  Created by FOREKS on 19.07.2023.
//

import Foundation
import UIKit

public protocol ArtistCoverImageDataSource: AnyObject {
    var artistImageView: String? { get set }
}

public protocol ArtistCoverImageEventSource: AnyObject {
    
}

public protocol ArtistCoverImageCellProtocol: ArtistCoverImageDataSource, ArtistCoverImageEventSource {
    
}

public final class ArtistCoverImageCellModel: ArtistCoverImageCellProtocol {
    
    public var artistImageView: String?
    
    public init(artistImageView: String?) {
        self.artistImageView = artistImageView
    }
}
