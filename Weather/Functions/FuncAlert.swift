//
//  FuncAlert.swift
//  Weather
//
//  Created by Roger Yong on 02/04/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

func displayAlertWithTitle(title: String?, message: String, viewController: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    let action = UIAlertAction(title: Translation.OK, style: .Cancel, handler: nil)
    alert.addAction(action)
    viewController.presentViewController(alert, animated: true, completion: nil)
}