//
//  Weather.swift
//  Weather
//
//  Created by Roger Yong on 30/03/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

protocol WeatherDelegate {
    func weatherData(data: [List])
    func ApiError()
}

class Weather: NSObject {
    var delegate: WeatherDelegate!
    
    func getWeather(cityId cityId: NSNumber) {
        TaskConfig.sharedInstance().getWeatherData(cityId) { (results, error) in
            if results == nil {
                self.delegate.ApiError()
            }
            else {
                self.populateJsonData(results!)
            }
        }
    }
    func populateJsonData(results: [String: AnyObject]?) {
        var lists = [List]()
        let items = results![JsonResponseKeys.List] as! [AnyObject]
        for item in items {
            let list = List()
            list.timeInterval = item[JsonResponseKeys.DateTime] as? NSTimeInterval
            let weathers = item[JsonResponseKeys.Weather] as? [AnyObject]
            let weather = weathers!.first
            let imageName = weather![JsonResponseKeys.Icon] as? String
            list.imageUrl = String(format: "http://openweathermap.org/img/w/%@.png", imageName!)
            list.information = weather![JsonResponseKeys.Description] as? String
            lists.append(list)
        }
        lists.sortInPlace({$0.timeInterval < $1.timeInterval })
        dispatch_async(dispatch_get_main_queue(), {
            self.delegate!.weatherData(lists)
        })
    }
}