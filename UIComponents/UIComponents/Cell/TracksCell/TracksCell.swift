//
//  TrackCell.swift
//  UIComponents
//
//  Created by FOREKS on 4.08.2023.
//

import UIKit
import TinyConstraints
import Kingfisher
import DataProvider

public protocol TracksCellDelegate: AnyObject {
    func likeSong(song: Song)
    func unlikeSong(song: Song)
}

public class TracksCell: UITableViewCell {
    
    public static let identifier = "TracksCell"
    
    weak var viewModel: TracksCellProtocol?
    public weak var trackCellDelegate: TracksCellDelegate?
    
    private let containerStackView = UIStackView()
    private let albumImageView = UIImageView()
    private let seperatorLineView = UIView()
    private let containerAlbumInfoView = UIView()
    private let albumInfoLabelStackView = UIStackView()
    private let albumNameLabel = UILabel()
    private let albumReleaseDayLabel = UILabel()
    private let likeContainerView = UIView()
    private let likeButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        configureContents()
    }
  
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureContents()
    }
    
    public func set(viewModel: TracksCellProtocol) {
        self.viewModel = viewModel
        configureContents()
    }
}

// MARK: - UILayout
extension TracksCell {
    private func addSubViews() {
        addContainerStackView()
        addAlbumImageView()
        addContainerAlbumInfoView()
        addAlbumInfoLabelsStackView()
        addLikeButton()
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
    
    private func addLikeButton() {
        containerStackView.addArrangedSubview(likeContainerView)
        likeContainerView.width(UIScreen.main.bounds.width / 5)
        likeContainerView.addSubview(likeButton)
        likeButton.centerInSuperview()
    }
}

// MARK: - Configure
extension TracksCell {
    private func configureContents() {
      configureStackViews()
      configureAlbumInfos()
      configureLikeButton()
      getLikedSongs()
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
    
    private func configureLikeButton() {
       likeButton.size(CGSize(width: 35 , height: 30))
       likeButton.tintColor = .red
       likeButton.clipsToBounds = true
       likeButton.contentHorizontalAlignment = .fill
       likeButton.contentVerticalAlignment = .fill
       likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
       likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    private func configureAlbumInfos() {
      guard let viewModel = viewModel else { return }
      albumImageView.kf.setImage(with: viewModel.trackImageUrl?.convertUrl)
      albumNameLabel.text = viewModel.trackNameText
      albumReleaseDayLabel.text = viewModel.trackDurationText
    }
    
    private func getLikedSongs() {
        if let data = UserDefaults.standard.object(forKey: "likedSongs") as? Data,
           let likedSongs = try? JSONDecoder().decode([Song].self, from: data) {
                if likedSongs.contains(where: { $0.musicId == viewModel?.musicId }) {
                    likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                    viewModel?.isLiked = true
                } else {
                    viewModel?.isLiked = false
                    likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
                }
        }
    }
}

// MARK: - Actions
extension TracksCell {
    @objc private func likeButtonTapped() {
        guard let viewModel = viewModel else { return }
        if viewModel.isLiked {
           viewModel.isLiked = false
           likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
           trackCellDelegate?.unlikeSong(song: Song(trackImageUrl: viewModel.trackImageUrl, trackDurationText: viewModel.trackDurationText,
               trackNameText: viewModel.trackNameText,
               musicUrl: viewModel.musicUrl,
               musicId: viewModel.musicId))
        } else {
            viewModel.isLiked = true
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            trackCellDelegate?.likeSong(song: Song(trackImageUrl: viewModel.trackImageUrl,
                                                   trackDurationText: viewModel.trackDurationText,
                                                   trackNameText: viewModel.trackNameText,
                                                   musicUrl: viewModel.musicUrl,
                                                   musicId: viewModel.musicId))
        }
    }
}

