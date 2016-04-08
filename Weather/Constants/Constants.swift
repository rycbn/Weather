//
//  Constants.swift
//  Weather
//
//  Created by Roger Yong on 30/03/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation

struct Selectors {
    static let GetWeatherData = "getWeatherData"
    static let CityPicker = "cityPicker:"
    static let Done = "done:"
    static let NativeBounds = "nativeBounds"

    struct ReceivedNotification {
        static let Weather = "receivedNotificationWeather:"
    }
}

struct Identifier {
    static let TableCell = "Cell"
}

struct UserDefaults {
    static let CityName = "cityName"
    static let CityId = "cityId"
}

struct ConstantKeys {
    static let DefaultCityName = "London"
    static let DefaultCityId: Double = 2643743
}

struct Notification {
    static let Reload = "ReloadViewController"
}