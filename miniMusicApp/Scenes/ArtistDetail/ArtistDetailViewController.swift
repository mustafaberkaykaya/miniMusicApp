//
//  ArtistDetailViewController.swift
//  miniMusicApp
//
//  Created by FOREKS on 8.07.2023.
//

import UIKit
import TinyConstraints
import Kingfisher
import UIComponents

final class ArtistDetailViewController: BaseViewController<ArtistDetailViewModel> {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.register(AlbumCell.self, forCellReuseIdentifier: AlbumCell.identifier)
        tableView.register(ArtistCoverImageCell.self, forCellReuseIdentifier: ArtistCoverImageCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews() 
        viewModel.didLoad()
        subscribeViewModel()
    }
}

// MARK: - UILayout
extension ArtistDetailViewController {
    private func addSubViews() {
        navigationItem.title = viewModel.artists.name
        addAlbumsTableView()
    }
    
    private func addAlbumsTableView() {
        self.view.addSubview(tableView)
        tableView.edgesToSuperview()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - SubscribeViewModel
extension ArtistDetailViewController {
    private func subscribeViewModel() {
        viewModel.reloadData = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension ArtistDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: ArtistCoverImageCell.identifier, for: indexPath) as? ArtistCoverImageCell {
                cell.set(viewModel: viewModel.cellForArtistCoverItemAt())
                return cell
            } else {
                return UITableViewCell()
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: AlbumCell.identifier, for: indexPath) as? AlbumCell {
                cell.set(viewModel: viewModel.cellForAlbumInfosItemAt(indexPath: indexPath))
                return cell
            } else {
                return UITableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return UIScreen.main.bounds.height / 3
        } else {
            return UIScreen.main.bounds.height / 7
        }
    }
}

