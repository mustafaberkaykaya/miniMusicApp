//
//  ArtistCell.swift
//  UIComponents
//
//  Created by FOREKS on 4.07.2023.
//

import UIKit
import TinyConstraints
import Kingfisher

public class ArtistCell: UICollectionViewCell {
    
    public static let identifier = "ArtistCell"
    
    private let artistImageView = UIImageView()
    private let artistTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    weak var viewModel: ArtistCellProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureContents()
    }
    
    public func set(viewModel: ArtistCellProtocol) {
        self.viewModel = viewModel
        configureContents()
    }
}

// MARK: - UILayout
extension ArtistCell {
    private func addSubViews() {
        addCategoryImage()
        addCategoryTitle()
    }
    
    private func addCategoryImage() {
        contentView.addSubview(artistImageView)
        artistImageView.edgesToSuperview()
        artistImageView.clipsToBounds = true
        artistImageView.layer.cornerRadius = 10
    }
    
    private func addCategoryTitle() {
        contentView.addSubview(artistTitleLabel)
        artistTitleLabel.bottomToSuperview().constant = -10
        artistTitleLabel.edgesToSuperview(excluding: [.bottom, .top], insets: .left(5) + .right(5))
    }
}

// MARK: - Configure
extension ArtistCell {
    private func configureContents() {
        guard let viewModel = viewModel else { return }
        artistImageView.kf.setImage(with: viewModel.artistImageView?.convertUrl)
        artistTitleLabel.text = viewModel.artistName
    }
}

