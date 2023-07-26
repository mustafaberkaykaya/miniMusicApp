//
//  ArtistCoverImageCell.swift
//  UIComponents
//
//  Created by FOREKS on 19.07.2023.
//

import UIKit
import TinyConstraints
import Kingfisher

public class ArtistCoverImageCell: UITableViewCell {
    
    public static let identifier = "ArtistCoverImageCell"
    
    weak var viewModel: ArtistCoverImageCellProtocol?
    
    private let artistImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        configureContents()
    }
  
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureContents()
    }
    
    public func set(viewModel: ArtistCoverImageCellProtocol) {
        self.viewModel = viewModel
        configureContents()
    }
}

// MARK: - UILayout
extension ArtistCoverImageCell {
    private func addSubViews() {
        addArtistImageView()
    }
    
    private func addArtistImageView() {
        contentView.addSubview(artistImageView)
        artistImageView.edgesToSuperview()
        artistImageView.contentMode = .scaleAspectFill
        artistImageView.layer.cornerRadius = 5
        artistImageView.clipsToBounds = true
    }
}

// MARK: - Configure
extension ArtistCoverImageCell {
    private func configureContents() {
        guard let viewModel = viewModel else { return }
        artistImageView.kf.setImage(with: viewModel.artistImageView?.convertUrl)
    }
}
