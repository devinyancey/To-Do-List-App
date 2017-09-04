//
//  ColorPalette.swift
//  Segmentio
//
//  Created by Dmitriy Demchenko
//  Copyright © 2016 Yalantis Mobile. All rights reserved.
//

import UIKit

struct ColorPalette {
    
    static let white = UIColor(red: 255, green: 255, blue: 255)
    static let black = UIColor(red: 3, green: 3, blue: 3)
    static let coral = UIColor(red: 244, green: 111, blue: 96)
    static let whiteSmoke = UIColor(red: 245, green: 245, blue: 245)
    static let grayChateau = UIColor(red: 163, green: 164, blue: 168)
    static let campfire:[String:UIColor] = ["nav":UIColor(red: 140, green: 70, blue:70),
                                            "addButton":UIColor(red:217, green:100, blue:89),
                                            "selectionColor":UIColor(red:242, green:174, blue:114)]
    
    static let scottMcCarthy:[String:UIColor] = ["nav":UIColor(red: 105, green: 145, blue:172),
                                                "addButton":UIColor(red:215, green:92, blue:55),
                                                "selectionColor":UIColor(red:195, green:215, blue:223)]
    
    static let werkPress:[String:UIColor] = ["nav":UIColor(red: 53, green: 64, blue:79),
                                                 "addButton":UIColor(red:228, green:95, blue:86),
                                                 "selectionColor":UIColor(red:195, green:215, blue:223)]
    
}
