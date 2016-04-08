//
//  City.swift
//  Weather
//
//  Created by Roger Yong on 31/03/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation
import CoreData

class City: NSManagedObject {
    // MARK:- GET
    class func count() -> Int {
        var error: NSError? = nil
        let fetchRequest = NSFetchRequest(entityName: EntityName.City)
        let count = appDelegate().coreDataStack.context.countForFetchRequest(fetchRequest, error: &error)
        return count
    }
    class func getData(id: Int) -> City {
        var data: City!
        let fetchRequest = NSFetchRequest(entityName: EntityName.City)
        fetchRequest.predicate = NSPredicate(format: "id = %li", id)
        do {
            let results = try appDelegate().coreDataStack.context.executeFetchRequest(fetchRequest) as! [City]
            data = results.first!
        }
        catch let error as NSError {
            print("Error: \(error)" + "description: \(error.localizedDescription)")
        }
        return data
    }
    class func getList() -> City {
        var data: City!
        let sort = NSSortDescriptor(key: "name", ascending: true)
        let fetchRequest = NSFetchRequest(entityName: EntityName.City)
        fetchRequest.sortDescriptors = [sort]
        do {
            let results = try appDelegate().coreDataStack.context.executeFetchRequest(fetchRequest) as! [City]
            data = results.first!
        }
        catch let error as NSError {
            print("Error: \(error)" + "description: \(error.localizedDescription)")
        }
        return data
    }
    // MARK:- INSERT
    class func insert(data: [String: AnyObject]) {
        let entity = NSEntityDescription.entityForName(EntityName.City, inManagedObjectContext: appDelegate().coreDataStack.context)
        let cities = data[JsonResponseKeys.Cities] as! [AnyObject]
        for city in cities {
            let item = City(entity: entity!, insertIntoManagedObjectContext: appDelegate().coreDataStack.context)
            item.id = city[JsonResponseKeys.Id] as? NSNumber
            item.name = city[JsonResponseKeys.Name] as? String
            item.imageName = city[JsonResponseKeys.ImageName] as? String
            if !getDefaultCity().found {
                if item.name == ConstantKeys.DefaultCityName {
                    NSUserDefaults.standardUserDefaults().setValue(item.name!, forKey: UserDefaults.CityName)
                    NSUserDefaults.standardUserDefaults().setValue(item.id!, forKey: UserDefaults.CityId)
                    NSUserDefaults.standardUserDefaults().synchronize()
                }
            }
        }
        appDelegate().coreDataStack.saveContext()
    }
}
