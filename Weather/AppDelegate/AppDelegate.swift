//
//  AppDelegate.swift
//  Weather
//
//  Created by Roger Yong on 30/03/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coreDataStack = CoreDataStack()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        importCityJsonDataIfNeeded()
        return true
    }
    func applicationWillResignActive(application: UIApplication) {}
    func applicationDidEnterBackground(application: UIApplication) {}
    func applicationWillEnterForeground(application: UIApplication) {}
    func applicationDidBecomeActive(application: UIApplication) {}
    func applicationWillTerminate(application: UIApplication) {}
}
extension AppDelegate {
    func importCityJsonDataIfNeeded() {
        //let count = City.count()
        if City.count() == 0 {
            importCityJsonData()
        }
    }
    func importCityJsonData() {
        let jsonFilePath = JsonDefault.City
        let jsonFileData = NSData(contentsOfFile: jsonFilePath!)
        do {
            let jsonFile = try NSJSONSerialization.JSONObjectWithData(jsonFileData!, options: .MutableContainers)
            insertJsonProductData(jsonFile as? [String : AnyObject])
        }
        catch let error as NSError {
            print("Erorr: \(error.localizedDescription)")
        }
    }
    func insertJsonProductData(results: [String: AnyObject]?) {
        City.insert(results!)
    }
}
