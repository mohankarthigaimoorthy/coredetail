//
//  Detail+CoreDataProperties.swift
//  coredata
//
//  Created by Imcrinox Mac on 26/12/1444 AH.
//
//

import Foundation
import CoreData


extension Detail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Detail> {
        return NSFetchRequest<Detail>(entityName: "Detail")
    }

    @NSManaged public var age: String?
    @NSManaged public var name: String?
    @NSManaged public var position: String?
    @NSManaged public var salary: Int64

}

extension Detail : Identifiable {

}
