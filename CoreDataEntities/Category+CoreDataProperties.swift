//
//  Category+CoreDataProperties.swift
//  piaskowo_serowa_KSIĄŻKA_KUCHARSKA
//
//  Created by apple on 09/06/2023.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String?
    @NSManaged public var toDish: NSSet?
    
    public var dishArray: [Dish]{
        let set = toDish as? Set<Dish> ?? []
        return set.sorted{
            $0.name! < $1.name!
        }
    }

}

// MARK: Generated accessors for toDish
extension Category {

    @objc(addToDishObject:)
    @NSManaged public func addToToDish(_ value: Dish)

    @objc(removeToDishObject:)
    @NSManaged public func removeFromToDish(_ value: Dish)

    @objc(addToDish:)
    @NSManaged public func addToToDish(_ values: NSSet)

    @objc(removeToDish:)
    @NSManaged public func removeFromToDish(_ values: NSSet)

}

extension Category : Identifiable {

}
