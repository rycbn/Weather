//
//  City+CoreDataProperties.swift
//  Weather
//
//  Created by Roger Yong on 01/04/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension City {

    @NSManaged var id: NSNumber?
    @NSManaged var name: String?
    @NSManaged var imageName: String?

}
