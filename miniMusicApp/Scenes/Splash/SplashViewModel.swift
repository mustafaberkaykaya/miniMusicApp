//
//  SplashViewModel.swift
//  miniMusicApp
//
//  Created by FOREKS on 27.06.2023.
//

import Foundation
import Alamofire

protocol SplashViewDataSource {
    var routeDelegate: SplashViewRouteDelegate? { get set }
}

protocol SplashViewEventSource {
    var updateTitle: AnyClosure<String?>? { get set }
    var showSplashLoading: VoidClosure? { get set }
}

protocol SplashViewRouteDelegate: AnyObject {
    func showHome()
}

protocol SplashViewProtocol: SplashViewDataSource, SplashViewEventSource {
    func viewDidLoad()
}

final class SplashViewModel: BaseViewModel, SplashViewProtocol {

    // EventSource
    var updateTitle: AnyClosure<String?>?
    var showSplashLoading: VoidClosure?
    
    // DataSource
    weak var routeDelegate: SplashViewRouteDelegate?
    
    func viewDidLoad() {
        if  NetworkReachabilityManager()?.isReachable ?? false {
            self.showSplashLoading?()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                guard let self = self else { return }
                self.routeDelegate?.showHome()
            }
        } else {
            updateTitle?("İnternet Yok")
        }
    }
}
