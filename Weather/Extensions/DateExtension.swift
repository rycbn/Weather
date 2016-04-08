//
//  DateExtension.swift
//  Weather
//
//  Created by Roger Yong on 01/04/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

extension NSDate {
    func toStringInYYYYMMDD() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let stringFromDate = formatter.stringFromDate(self)
        return stringFromDate
    }
    func toStringInHHMMDDslashMMslashYYYY() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "hh:mm dd/MM/yyyy"
        let stringFromDate = formatter.stringFromDate(self)
        return stringFromDate
    }

}
