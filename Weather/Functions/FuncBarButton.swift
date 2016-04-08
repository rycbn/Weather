//
//  FuncBarButton.swift
//  Weather
//
//  Created by Roger Yong on 31/03/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

func geographyBarButtonItem(target viewController: UIViewController) -> UIBarButtonItem {
    let barButtonItem = UIBarButtonItem(image: geography(), style: .Plain, target: viewController, action: Selector(Selectors.CityPicker))
    return barButtonItem
}

