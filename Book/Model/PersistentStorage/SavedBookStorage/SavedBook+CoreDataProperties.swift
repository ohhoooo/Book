//
//  SavedBook+CoreDataProperties.swift
//  Book
//
//  Created by 김정호 on 5/8/24.
//
//

import Foundation
import CoreData


extension SavedBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedBook> {
        return NSFetchRequest<SavedBook>(entityName: "SavedBook")
    }

    @NSManaged public var authors: String?
    @NSManaged public var price: Int16
    @NSManaged public var thumbnail: Data?
    @NSManaged public var title: String?

}

extension SavedBook : Identifiable {

}
