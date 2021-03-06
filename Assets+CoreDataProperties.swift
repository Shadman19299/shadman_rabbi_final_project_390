//
//  Assets+CoreDataProperties.swift
//  shadman_rabbi_final_project_390
//
//  Created by Shadman UR Rabbi on 7/4/21.
//
//

import Foundation
import CoreData


extension Assets {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Assets> {
        return NSFetchRequest<Assets>(entityName: "Assets")
    }

    @NSManaged public var dateregisterd: Date?
    @NSManaged public var devicetype: String?
    @NSManaged public var foundlocation: String?
    @NSManaged public var ittag: String?
    @NSManaged public var supposedlocation: String?

}

extension Assets : Identifiable {

}
