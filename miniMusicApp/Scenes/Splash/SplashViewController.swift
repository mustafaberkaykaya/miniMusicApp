//
//  SplashViewController.swift
//  miniMusicApp
//
//  Created by FOREKS on 27.06.2023.
//

import UIKit
import TinyConstraints
import UIComponents

final class SplashViewController: BaseViewController<SplashViewModel> {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        subscribeViewModel()
        viewModel.viewDidLoad()
    }
}

// MARK: - UI Layout
extension SplashViewController {
    
    private func addSubViews() {
        addTitleLabel()
    }
    
    private func addTitleLabel() {
        self.view.backgroundColor = .systemGreen
        view.addSubview(titleLabel)
        titleLabel.centerInSuperview()
    }
}

// MARK: - SubscribeViewModel
extension SplashViewController {
    
    private func subscribeViewModel() {
        viewModel.updateTitle = { [weak self] text in
            guard let self = self else { return }
            self.titleLabel.text = text
        }
        
        viewModel.showSplashLoading = { [weak self] in
            guard let self = self else { return }
            let loadingView = LoadingView(frame: self.view.bounds, jsonName: "splash", size: 300)
            loadingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.view.addSubview(loadingView)
        }
    }
}

// MARK: - RouteDelegate
extension SplashViewController: SplashViewRouteDelegate {
    
    func showHome() {
        guard let window = app.router.window else { return }
        let homeViewController = CategoriesRouter.create()
        UIView.transition(with: window, duration: 1, options: .transitionFlipFromBottom, animations: {
            UIView.performWithoutAnimation {
                window.rootViewController = homeViewController
            }
        }, completion: nil)
    }
}

