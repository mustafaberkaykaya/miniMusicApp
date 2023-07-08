//
//  CategoriesCell.swift
//  UIComponents
//
//  Created by FOREKS on 30.06.2023.
//

import UIKit
import TinyConstraints
import Kingfisher

public class CategoriesCell: UICollectionViewCell {
    
    public static let identifier = "CategoriesCell"
    
    private let categoryImageView = UIImageView()
    private let categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    weak var viewModel: CategoriesCellProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureContents()
    }
    
    public func set(viewModel: CategoriesCellProtocol) {
        self.viewModel = viewModel
        configureContents()
    }
}

// MARK: - UILayout
extension CategoriesCell {
    private func addSubViews() {
        addCategoryImage()
        addCategoryTitle()
    }
    
    private func addCategoryImage() {
        contentView.addSubview(categoryImageView)
        categoryImageView.edgesToSuperview()
    }
    
    private func addCategoryTitle() {
        contentView.addSubview(categoryTitleLabel)
        categoryTitleLabel.bottomToSuperview().constant = -10
        categoryTitleLabel.centerXToSuperview()
        categoryImageView.clipsToBounds = true
        categoryImageView.layer.cornerRadius = 10
    }
}

// MARK: - Configure
extension CategoriesCell {
    private func configureContents() {
        guard let viewModel = viewModel else { return }
        categoryImageView.kf.setImage(with: viewModel.categoryImageView?.convertUrl)
        categoryTitleLabel.text = viewModel.categoryName
    }
}
