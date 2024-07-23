//
//  Theatre+CoreDataProperties.swift
//  MovieApplication
//
//  Created by Preetika Kuntala on 16/11/21.
//
//

import Foundation
import CoreData


extension Theatre {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Theatre> {
        return NSFetchRequest<Theatre>(entityName: "Theatre")
    }

    @NSManaged public var tname: String?
    @NSManaged public var tlocation: String?

}

extension Theatre : Identifiable {

}
