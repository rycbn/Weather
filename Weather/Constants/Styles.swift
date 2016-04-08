//
//  Styles.swift
//  Weather
//
//  Created by Roger Yong on 30/03/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

struct ImageName {
    static let Default = "world"
    static let Geography = "icon_geography"
    static let Cloud = "cloud"
}

struct Height {
    static let TableHeader: CGFloat = Device.Phone4 || Device.Phone5 ? 200 : 250
    static let Button: CGFloat      = 45
}

struct Width {
    static let LongButton: CGFloat = Device.Width - Padding.Left.Regular - Padding.Right.Regular
    static let PickerView: CGFloat = Device.Width - Padding.Left.Regular - Padding.Right.Regular
    static let Button: CGFloat = 80
}

struct FontNameHelveticaNeue {
    static let Bold = "HelveticaNeue-Bold"
    static let Medium = "HelveticaNeue-Medium"
    static let Regular = "HelveticaNeue-Regular"
}

struct FontSize {
    static let Tiny: CGFloat = 12
    static let Small: CGFloat = 14
    static let Medium: CGFloat = 16
    static let Large: CGFloat = 18
    static let ExtraLarge: CGFloat = 20
}

struct Color {
    static let SlateGray    = "363638"
    static let Red          = "E05206"
    static let Blue         = "41A9E0"
    static let Black        = "000000"
    static let White        = "FFFFFF"
    static let Gray         = "F2F2F2"
    static let LightGray    = "C2C2C2"
}

struct Padding {
    static let Spacing: CGFloat = 10
    struct Top {
        static let Table: CGFloat = 15
        static let Regular: CGFloat = 10
        static let RegularHalf: CGFloat = 5
    }
    struct Left {
        static let Table: CGFloat = 15
        static let Regular: CGFloat = 10
        static let RegularHalf: CGFloat = 5
    }
    struct Right {
        static let Table: CGFloat = 15
        static let Regular: CGFloat = 10
        static let RegularHalf: CGFloat = 5
    }
}

