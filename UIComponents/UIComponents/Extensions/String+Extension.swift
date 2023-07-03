//
//  String+Extension.swift
//  UIComponents
//
//  Created by FOREKS on 3.07.2023.
//

public extension String {
    var convertUrl: URL? {
        let string = self.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        if let string = string {
            return URL(string: string)
        } else {
            return nil
        }
    }
}
