//
//  FuncImage.swift
//  Weather
//
//  Created by Roger Yong on 31/03/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

func geography() -> UIImage? {
    if let image = UIImage(named: "icon_geography")?.imageWithRenderingMode(.AlwaysTemplate) {
        return image
    }
    return nil
}
func imageTransition() -> CATransition {
    let transition = CATransition()
    transition.duration = 1.0
    transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    transition.type = kCATransitionFade
    return transition
}