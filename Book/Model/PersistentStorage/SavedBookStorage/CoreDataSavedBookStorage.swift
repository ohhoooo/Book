//
//  CoreDataSavedBookStorage.swift
//  Book
//
//  Created by 김정호 on 5/8/24.
//

import UIKit
import CoreData

final class CoreDataSavedBookStorage {
    
    // MARK: - properties
    static let shared = CoreDataSavedBookStorage()
    private init() {}
    
    private let modelName = "SavedBook"
    
    // 앱 델리게이트
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    // 임시저장소
    private lazy var context = appDelegate?.persistentContainer.viewContext
    
    // MARK: - methods
    private func contains(book: Book) -> Bool {
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            request.predicate = NSPredicate(format: "title == %@", book.title)
            
            do {
                if let fetchedSavedBooks = try context.fetch(request) as? [SavedBook] {
                    return (book.title == (fetchedSavedBooks.first?.title ?? "")) ? true : false
                }
            } catch {
                return false
            }
        }
        
        return false
    }
}
