//
//  Dish+CoreDataProperties.swift
//  piaskowo_serowa_KSIĄŻKA_KUCHARSKA
//
//  Created by apple on 09/06/2023.
//
//

import Foundation
import CoreData


extension Dish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dish> {
        return NSFetchRequest<Dish>(entityName: "Dish")
    }

    @NSManaged public var difficulty: Int16
    @NSManaged public var ingredients: String?
    @NSManaged public var name: String?
    @NSManaged public var steps: String?
    @NSManaged public var toCategory: Category?

}

extension Dish : Identifiable {

}
