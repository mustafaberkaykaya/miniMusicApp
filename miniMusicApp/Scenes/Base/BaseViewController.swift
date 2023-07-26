//
//  BaseViewController.swift
//  miniMusicApp
//
//  Created by FOREKS on 27.06.2023.
//
import Foundation
import UIKit
import UIComponents

class BaseViewController<V: BaseViewModelProtocol>: UIViewController {
    
    var viewModel: V
    
    init(viewModel: V) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // swiftlint:disable fatal_error unavailable_function
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // swiftlint:enable fatal_error unavailable_function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContents()
        subscribeLoading()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isTranslucent = false
        self.tabBarController?.tabBar.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
    }
    
    private func configureContents() {
        view.backgroundColor = .white
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
#if DEBUG
    deinit {
        debugPrint("deinit \(self)")
    }
#endif
}

// MARK: - Loading
extension BaseViewController {
    
    private func subscribeLoading() {
        viewModel.showLoading = { [weak self] in
            guard let self = self else { return }
            let loadingView = LoadingView(frame: self.view.bounds, jsonName: "loading", size: 50)
            loadingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.view.addSubview(loadingView)
        }
        
        viewModel.hideLoading = { [weak self] in
            guard let self = self else { return }
            self.view.subviews.filter({ $0 is LoadingView }).forEach({ $0.removeFromSuperview() })
        }
    }
}
