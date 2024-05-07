//
//  Int+Extension.swift
//  Book
//
//  Created by 김정호 on 5/7/24.
//

import Foundation

extension Int {
    func insertCommas() -> String {
        let numberFormatter: NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(for: self) ?? "0"
    }
}
