//
//  TableCell+CoreDataProperties.swift
//  PhotoNotes
//
//  Created by Иван Лебедев on 10.06.2020.
//  Copyright © 2020 Иван Лебедев. All rights reserved.
//
//

import Foundation
import CoreData


extension TableCell {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TableCell> {
        return NSFetchRequest<TableCell>(entityName: "TableCell")
    }

    @NSManaged public var address: String?
    @NSManaged public var date: String?
    @NSManaged public var descr: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var photo: Data?

}
