//
//  CategoriesCellModel.swift
//  UIComponents
//
//  Created by FOREKS on 30.06.2023.
//

import Foundation
import UIKit

public protocol CategoriesCellDataSource: AnyObject {
    var categoryImageView: String? { get set }
    var categoryName: String? { get set }
}

public protocol CategoriesCellEventSource: AnyObject {
    
}

public protocol CategoriesCellProtocol: CategoriesCellDataSource, CategoriesCellEventSource {
    
}

public final class CategoriesCellModel: CategoriesCellProtocol {
    
    public var categoryImageView: String?
    public var categoryName: String?
    
    public init(categoryImageView: String?, categoryName: String?) {
        self.categoryImageView = categoryImageView
        self.categoryName = categoryName
    }
}
