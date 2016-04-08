//
//  Config.swift
//  Weather
//
//  Created by Roger Yong on 30/03/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation

struct Client {
    static let Name = "Weather"
}

struct EntityName {
    static let City = "City"
}

struct Constants {
    static let BaseUrl = "http://api.openweathermap.org/"
    static let AppKey = "4628a5a9beb895234420c9b532780302"
}

struct Methods {
    static let ForecastDataVersion = "data/2.5/forecast"
}

struct ParametersKeys {
    static let CityId   = "id"
    static let AppId    = "APPID"
}

struct UrlKeys {
    //static let DefaultCity: Double = 2643743
}

struct JsonDefault {
    static let City = NSBundle.mainBundle().pathForResource("cities", ofType: "json")
    static let Weather = NSBundle.mainBundle().pathForResource("london", ofType: "json")
}

struct JsonResponseKeys {
    static let List = "list"
    static let Cities = "Cities"
    static let Id = "id"
    static let Name = "name"
    static let ImageName = "imageName"
    static let Description = "description"
    static let Icon = "icon"
    static let DateTime = "dt"
    static let Weather = "weather"
}

struct JsonResponseKeyPaths {
    static let ListWeatherIcon = "list.weather.icon"
    static let ListDateTime = "list.dt"
    static let ListWeatherDescription = "list.weather.description"
}

struct JsonErrorKey {
    static let Error = "Error"
}

struct JsonErrorValue {
    static let Error = "Error"
    static let BadRequest = "BadRequest"
    static let Unauthorized = "Unauthorized"
    static let NoData = "NoData"
    static let AuthorizationDenied = "Authorization has been denied for this request."
}