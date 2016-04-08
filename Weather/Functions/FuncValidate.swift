//
//  FuncValidate.swift
//  Weather
//
//  Created by Roger Yong on 31/03/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit
import CoreTelephony

func hasCellularCoverage() -> Bool {
    let carrier = CTCarrier()
    let subscriber = CTSubscriber()
    if !(carrier.mobileCountryCode != nil) { return false }
    if !(subscriber.carrierToken != nil) { return false }
    return true
}

func isNetworkOrCellularCoverageReachable() -> Bool  {
    let reachability = Reachability.reachabilityForInternetConnection()
    return (reachability!.isReachable() || hasCellularCoverage())
}

func isReachableViaWifi() -> Bool {
    let reachability = Reachability.reachabilityForInternetConnection()
    return reachability!.isReachableViaWiFi()
}

func getDefaultCity() -> (name: String?, id: Double?, found: Bool) {
    let cityName = NSUserDefaults.standardUserDefaults().objectForKey(UserDefaults.CityName) as? String
    let cityId = NSUserDefaults.standardUserDefaults().objectForKey(UserDefaults.CityId) as? Double
    var isFound = true
    if cityName == nil {
        isFound = false
    }
    return (cityName, cityId, isFound)
}