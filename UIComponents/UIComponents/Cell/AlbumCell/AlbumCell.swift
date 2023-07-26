//
//  AlbumCell.swift
//  UIComponents
//
//  Created by FOREKS on 16.07.2023.
//

import UIKit
import TinyConstraints
import Kingfisher

public class AlbumCell: UITableViewCell {
    
    public static let identifier = "AlbumCell"
    
    weak var viewModel: AlbumCellProtocol?
    
    private let containerStackView = UIStackView()
    private let albumImageView = UIImageView()
    private let seperatorLineView = UIView()
    private let containerAlbumInfoView = UIView()
    private let albumInfoLabelStackView = UIStackView()
    private let albumNameLabel = UILabel()
    private let albumReleaseDayLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        configureContents()
    }
  
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureContents()
    }
    
    public func set(viewModel: AlbumCellProtocol) {
        self.viewModel = viewModel
        configureContents()
    }
}

// MARK: - UILayout
extension AlbumCell {
    private func addSubViews() {
        addContainerStackView()
        addAlbumImageView()
        addContainerAlbumInfoView()
        addAlbumInfoLabelsStackView()
    }
    
    private func addContainerStackView() {
        contentView.addSubview(containerStackView)
        containerStackView.edgesToSuperview(insets: .top(5) + .bottom(5) + .left(5) + .right(5))
    }
    
    private func addAlbumImageView() {
        containerStackView.addArrangedSubview(albumImageView)
        albumImageView.heightToSuperview()
        albumImageView.width(UIScreen.main.bounds.width / 4)
        albumImageView.clipsToBounds = true
        albumImageView.layer.cornerRadius = 5
    }
    
    private func addContainerAlbumInfoView() {
        containerStackView.addArrangedSubview(containerAlbumInfoView)
        containerAlbumInfoView.heightToSuperview()
    }
    
    private func addAlbumInfoLabelsStackView() {
        containerAlbumInfoView.addSubview(albumInfoLabelStackView)
        albumInfoLabelStackView.edgesToSuperview(insets: .top(10) + .right(5) + .left(15) + .bottom(10))
        albumInfoLabelStackView.addArrangedSubview(albumNameLabel)
        albumNameLabel.height(35)
        albumInfoLabelStackView.addArrangedSubview(albumReleaseDayLabel)
        albumNameLabel.height(35)
    }
}

// MARK: - Configure
extension AlbumCell {
    private func configureContents() {
      configureStackViews()
      configureAlbumInfos()
    }
    
    private func configureStackViews() {
      containerStackView.layer.borderWidth = 0.5
      containerStackView.layer.cornerRadius = 5
      containerStackView.clipsToBounds = true
      containerStackView.layer.borderColor = UIColor.lightGray.cgColor
      containerStackView.axis = .horizontal
      containerStackView.alignment = .fill
      albumInfoLabelStackView.axis = .vertical
      albumInfoLabelStackView.spacing = 5
    }
    
    private func configureAlbumInfos() {
      guard let viewModel = viewModel else { return }
      albumImageView.kf.setImage(with: viewModel.albumImageUrl?.convertUrl)
      albumNameLabel.text = viewModel.albumNameText
      albumReleaseDayLabel.text = viewModel.albumReleaseDayText
    }
}
