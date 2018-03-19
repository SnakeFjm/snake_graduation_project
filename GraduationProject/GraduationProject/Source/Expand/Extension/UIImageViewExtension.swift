//
//  UIImageViewExtension.swift
//  FoodDetect
//
//  Created by dev on 2017/11/30.
//  Copyright © 2017年 iAskDoc Technology. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher


extension UIImageView {
    
    
    // 设置图片
    func setImageUrl(_ path: String, placeholder: UIImage? = nil) {
        let imagePath = URLManager.domainSourcePath(path)
        if let url: URL = URL.init(string: imagePath) {
            let image: UIImage = (placeholder == nil ? UIImage(named: "placeholder") : placeholder)!
            self.kf.setImage(with: url, placeholder: image, options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
    // 设置头像图片 
    func setHeadImageUrl(_ path: String) {
        self.setImageUrl(path, placeholder: #imageLiteral(resourceName: "placeholder_head"))
    }
    
    
}

