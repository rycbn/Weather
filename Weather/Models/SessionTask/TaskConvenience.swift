//
//  TaskConvenience.swift
//  Weather
//
//  Created by Roger Yong on 30/03/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation

extension TaskConfig {
    func getWeatherData(cityId: NSNumber, completionHandler: (results: [String: AnyObject]?, error: NSError?) -> Void) {
        let parameters = [ParametersKeys.CityId: cityId, ParametersKeys.AppId: Constants.AppKey]
        let mutableMethod: String = Methods.ForecastDataVersion
        taskForGETMethod(mutableMethod, parameters: parameters) { (JSONResult, error) in
            if let error = error {
                completionHandler(results: nil, error: error)
            }
            else {
                if let result = JSONResult as? [String: AnyObject] {
                    completionHandler(results: result, error: nil)
                }
                else {
                    completionHandler(results: nil, error: NSError(domain: "\(#function) parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse \(#function)"]))
                }
            }
        }
    }
}