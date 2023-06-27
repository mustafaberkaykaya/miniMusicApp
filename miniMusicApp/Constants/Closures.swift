//
//  Closures.swift
//  miniMusicApp
//
//  Created by FOREKS on 27.06.2023.
//

import Foundation

typealias VoidClosure = (() -> Void)
typealias StringClosure = ((String) -> Void)
typealias IntClosure = ((Int) -> Void)
typealias DoubleClosure = ((Double) -> Void)
typealias AnyClosure<T: Any> = ((T) -> Void)
typealias BoolClosure = ((Bool) -> Void)
