//
//  UserDefaultsRecentViewedBookStorage.swift
//  Book
//
//  Created by 김정호 on 5/10/24.
//

import Foundation

final class UserDefaultsRecentViewedBookStorage {
    
    // MARK: - properties
    static let shared = UserDefaultsRecentViewedBookStorage()
    private init() {}
    
    private let userDefaults = UserDefaults.standard
    
    // MARK: - methods
}
