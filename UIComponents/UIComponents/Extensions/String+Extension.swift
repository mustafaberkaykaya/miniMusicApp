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

public extension Int {
    func secondsToMinutes(seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        
        let formattedTime = String(format: "%02d:%02d", minutes, remainingSeconds)
        return formattedTime
    }

}
