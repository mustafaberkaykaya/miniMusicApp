//
//  ArtistsViewController.swift
//  miniMusicApp
//
//  Created by FOREKS on 4.07.2023.
//

import UIKit
import TinyConstraints
import UIComponents

final class ArtistsViewController: BaseViewController<ArtistsViewModel> {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2) - 10 , height:  (UIScreen.main.bounds.width / 2) - 10)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ArtistCell.self, forCellWithReuseIdentifier: ArtistCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        viewModel.didLoad()
        subscribeViewModel()
    }
}

// MARK: - SubscribeViewModel
extension ArtistsViewController {
    private func subscribeViewModel() {
        viewModel.reloadData = { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UILayout
extension ArtistsViewController {
    private func addSubViews() {
        addPageTitle()
        addCollectionView()
    }
    
    private func addPageTitle() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = viewModel.category.name
    }
    
    private func addCollectionView() {
        view.addSubview(collectionView)
        collectionView.edgesToSuperview(usingSafeArea: true)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - CollectionView Delegates
extension ArtistsViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtistCell.identifier, for: indexPath) as? ArtistCell {
            cell.set(viewModel: viewModel.cellForItemAt(indexPath: indexPath))
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
