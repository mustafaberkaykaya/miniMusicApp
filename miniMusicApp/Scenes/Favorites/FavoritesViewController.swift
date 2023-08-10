//
//  FavoritesViewController.swift
//  miniMusicApp
//
//  Created by FOREKS on 29.06.2023.
//

import UIKit
import TinyConstraints
import UIComponents

final class FavoritesViewController: BaseViewController<FavoritesViewModel> {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.register(TracksCell.self, forCellReuseIdentifier: TracksCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getLikedSongs()
        subscribeViewModel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.audioPlayer?.stop()
    }
}

// MARK: - UILayout
extension FavoritesViewController {
    private func addSubViews() {
        navigationItem.title = "Beğenilenler"
        addTableView()
    }
    
    private func addTableView() {
        self.view.addSubview(tableView)
        tableView.edgesToSuperview()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - SubscribeViewModel
extension FavoritesViewController {
    private func subscribeViewModel() {
        viewModel.reloadData = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TracksCell.identifier, for: indexPath) as? TracksCell {
            cell.set(viewModel: viewModel.cellForTrackCellItemAt(indexPath: indexPath))
            cell.trackCellDelegate = self
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 7
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath: indexPath)
    }
    
}

// MARK: - TracksCellDelegate
extension FavoritesViewController: TracksCellDelegate {
    func likeSong(song: Song) {
        viewModel.likeSong(song: song)
    }
    
    func unlikeSong(song: Song) {
        viewModel.unlikeSong(song: song)
    }
}

