//
//  UIColorExtension.swift
//  FoodDetect
//
//  Created by dev on 2017/12/16.
//  Copyright © 2017年 iAskDoc Technology. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static func RGBMake(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) -> UIColor {
        return UIColor.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    static func RGBSameMake(value: CGFloat, a: CGFloat = 1) -> UIColor {
        return RGBMake(r: value, g: value, b: value, a: a)
    }
    
}
