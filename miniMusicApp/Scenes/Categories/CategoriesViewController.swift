//
//  CategoriesViewController.swift
//  miniMusicApp
//
//  Created by FOREKS on 27.06.2023.
//

import UIKit
import TinyConstraints
import UIComponents
import DataProvider

final class CategoriesViewController: BaseViewController<CategoriesViewModel> {
    
    private let symbolTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Kategoriler"
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2) - 10 , height:  (UIScreen.main.bounds.width / 2) - 10)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: CategoriesCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        viewModel.didLoad()
        subscribeViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
    }
}

// MARK: - UILayout
extension CategoriesViewController {
    private func addSubViews() {
        addPageTitle()
        addCollectionView()
    }
    
    private func addPageTitle() {
        self.view.addSubview(symbolTitleLabel)
        symbolTitleLabel.centerXToSuperview()
        symbolTitleLabel.topToSuperview(usingSafeArea: true).constant = 10
    }
    
    private func addCollectionView() {
        view.addSubview(collectionView)
        collectionView.topToBottom(of: symbolTitleLabel).constant = 5
        collectionView.edgesToSuperview(excluding: .top, usingSafeArea: true)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - SubscribeViewModel
extension CategoriesViewController {
    private func subscribeViewModel() {
        viewModel.reloadData = { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
    }
}

// MARK: - CollectionView Delegates
extension CategoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.identifier, for: indexPath) as? CategoriesCell {
            cell.set(viewModel: viewModel.cellForItemAt(indexPath: indexPath))
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(indexPath: indexPath)
    }
}

// MARK: - RouteDelegate
extension CategoriesViewController: CategoriesRouteDelegate {

    func showArtist(category: CategoriesData) {
        let viewController = ArtistsRouter.create(category: category)
        navigationController?.pushViewController(viewController, animated: false)
    }
}
