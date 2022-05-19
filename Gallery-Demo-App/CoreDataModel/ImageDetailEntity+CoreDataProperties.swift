//
//  ImageDetailEntity+CoreDataProperties.swift
//  
//
//  Created by vignesh kumar c on 18/05/22.
//
//

import Foundation
import CoreData


extension ImageDetailEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageDetailEntity> {
        return NSFetchRequest<ImageDetailEntity>(entityName: "ImageDetailEntity")
    }

    @NSManaged public var img: Data?
    @NSManaged public var imgName: String?
    @NSManaged public var likes: Int64

}
