//
//  Consulta+CoreDataProperties.swift
//  
//
//  Created by Gilson Gil on 24/11/18.
//
//

import Foundation
import CoreData


extension Consulta {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Consulta> {
        return NSFetchRequest<Consulta>(entityName: "Consulta")
    }

    @NSManaged public var json: NSData?
    @NSManaged public var url: String?
    @NSManaged public var documentId: String?

}
