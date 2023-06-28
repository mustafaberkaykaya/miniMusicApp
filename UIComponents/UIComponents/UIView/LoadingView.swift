//
//  LoadingView.swift
//  UIComponents
//
//  Created by FOREKS on 27.06.2023.
//

import Foundation
import UIKit
import Lottie
import TinyConstraints

public class LoadingView: UIView {
    
    private var jsonName: String
    private var animationView: LottieAnimationView
    private var size: CGFloat
    
    public init(frame: CGRect, jsonName: String, size: CGFloat) {
        self.jsonName = jsonName
        self.animationView = LottieAnimationView(name: jsonName)
        self.size = size
        super.init(frame: frame)
        addSubViews()
        configureContents()
    }
    
    // swiftlint:disable fatal_error unavailable_function
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Layout
extension LoadingView {
    
    private func addSubViews() {
        addAnimationView()
    }
    
    private func addAnimationView() {
        addSubview(animationView)
        animationView.centerInSuperview()
    }
}

// MARK: - Configure
extension LoadingView {
    
    private func configureContents() {
        backgroundColor = .black.withAlphaComponent(0.25)
        configureAnimationView()
    }
    
    private func configureAnimationView() {
        animationView.contentMode = .scaleAspectFit
        animationView.size(.init(width: size, height: size))
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.75
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.play()
    }
}

