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
    func fetchSavedBooks() -> [SavedBook] {
        var savedBooks: [SavedBook] = []
        
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            
            do {
                if let fetchedSavedBooks = try context.fetch(request) as? [SavedBook] {
                    savedBooks = fetchedSavedBooks
                }
            } catch {
                return savedBooks
            }
        }
        
        return savedBooks
    }
    
    func saveBook(book: Book, thumbnail: Data?, completion: @escaping (Result<SavedBook, Error>) -> Void) {
        if self.contains(book: book) {
            completion(.failure(CoreDataError.existingItemError))
            return
        }
        
        if let context = context {
            if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) {
                if let savedBook = NSManagedObject(entity: entity, insertInto: context) as? SavedBook {
                    savedBook.title = book.title
                    savedBook.authors = book.authors.first
                    savedBook.price = Int16(clamping: book.price)
                    savedBook.thumbnail = thumbnail
                    
                    appDelegate?.saveContext()
                    completion(.success(savedBook))
                }
            }
        }
    }
    
    func deleteBook(book: SavedBook, completion: @escaping ((Result<[SavedBook], Error>) -> Void)) {
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            request.predicate = NSPredicate(format: "title == %@", book.title ?? "")
            
            do {
                if let fetchedSavedBook = try context.fetch(request) as? [SavedBook] {
                    if let targetSavedBook = fetchedSavedBook.first {
                        context.delete(targetSavedBook)
                        appDelegate?.saveContext()
                        
                        completion(.success(fetchSavedBooks()))
                    }
                }
            } catch {
                completion(.failure(CoreDataError.notfoundItemError))
            }
        }
    }
    
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
