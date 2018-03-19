//
//  UIImageExtension.swift
//  FoodDetect
//
//  Created by dev on 2017/12/14.
//  Copyright © 2017年 iAskDoc Technology. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    
    // 获取某一点的颜色
    func colorAtPixel(point: CGPoint) -> UIColor? {
        //
        let bounds = CGRect(origin: CGPoint(x: 0, y: 0), size: self.size)
        if bounds.contains(point) {
            return nil
        }
        //
        guard let cgImage: CGImage = self.cgImage else {
            debugPrint("can't get cgImage")
            return nil
        }
        guard let dataProvider: CGDataProvider = cgImage.dataProvider else {
            return nil
        }
        guard let pixelData: CFData = dataProvider.data else {
            return nil
        }

        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        let pixelInfo: Int = ((Int(self.size.width) * Int(point.y)) + Int(point.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        return UIColor.init(red: r, green: g, blue: b, alpha: a)
    }
    
}
