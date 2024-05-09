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
    func fetchRecentViewedBooks() -> [String] {
        return userDefaults.object(forKey: "RecentViewedBooks") as? [String] ?? [String]()
    }
    
    func saveRecentViewedBook(title: String) -> [String] {
        var recentViewedBooks = fetchRecentViewedBooks()
        
        if recentViewedBooks.contains(title) {
            if let index = recentViewedBooks.firstIndex(of: title) {
                recentViewedBooks.remove(at: index)
            }
        } else {
            if recentViewedBooks.count > 9 {
                recentViewedBooks.remove(at: recentViewedBooks.count-1)
            }
        }
        
        recentViewedBooks.insert(title, at: 0)
        userDefaults.set(recentViewedBooks, forKey: "RecentViewedBooks")
        
        return fetchRecentViewedBooks()
    }
}
