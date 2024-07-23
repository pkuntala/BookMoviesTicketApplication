//
//  Movie+CoreDataProperties.swift
//  MovieApplication
//
//  Created by Abhishek Arunkumar on 16/11/21.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var genre: String?
    @NSManaged public var movieDescription: String?
    @NSManaged public var movieImgName: String?
    @NSManaged public var movieLanguage: String?
    @NSManaged public var name: String?
    @NSManaged public var noOfHours: String?
    @NSManaged public var rating: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var movieLocation: String?

}

extension Movie : Identifiable {

}
