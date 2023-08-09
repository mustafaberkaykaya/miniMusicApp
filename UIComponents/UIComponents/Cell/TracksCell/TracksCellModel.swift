//
//  TracksCellModel.swift
//  UIComponents
//
//  Created by FOREKS on 4.08.2023.
//

import Foundation
import UIKit
import DataProvider

public protocol TracksCellDataSource: AnyObject {
    var trackImageUrl: String? { get set }
    var trackNameText: String? { get set }
    var trackDurationText: String? { get set }
    var musicUrl: String? { get set }
    var musicId: Int? { get set }
    var isLiked: Bool { get set }
}

public protocol TracksCellEventSource: AnyObject {
}

public protocol TracksCellProtocol: TracksCellDataSource, TracksCellEventSource {
  
}

public final class TracksCellModel: TracksCellProtocol {
    
    public var trackImageUrl: String?
    public var trackDurationText: String?
    public var trackNameText: String?
    public var musicUrl: String?
    public var musicId: Int?
    public var isLiked: Bool = false 
    
    public init(trackImageUrl: String?,
                trackDurationText: String?,
                trackNameText: String?,
                musicUrl: String?,
                musicId: Int?) {
        self.trackImageUrl = trackImageUrl
        self.trackDurationText = trackDurationText
        self.trackNameText = trackNameText
        self.musicUrl = musicUrl
        self.musicId = musicId
    }
}

