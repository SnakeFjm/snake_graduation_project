//
//  BaseViewControllerExtension.swift
//  renbo
//
//  Created by Chensh on 2018/3/10.
//  Copyright © 2018年 iAskDoc Technology. All rights reserved.
//

import Foundation

extension BaseViewController {
    
    // 将导航栏更改为渐变的蓝色
    func ChangeNavigationBarBgImageToBlue() {
        let image = UIImage.qmui_image(with: UIColor.RGBMake(r: 0x2D, g: 0xA7, b: 0xE9), size: CGSize(width: ScreenWidth, height: NavigationBarHeight), cornerRadius: 0)
        self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        //
        self.navigationController?.navigationBar.titleTextAttributes =  [NSAttributedStringKey.foregroundColor : UIColor.white]
    }
    
    func resetBlueNavigationBar() {
        //
        self.resetNavBarShadowLine()
        //
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.RGBSameMake(value: 0x33)]
        //
    }
    
    
    //
    func createBlueGradientView(size: CGSize) -> UIView {
        let frame: CGRect = CGRect(origin: CGPoint(), size: size)
        let view = UIView.init(frame: frame)
        //
        let layer: CAGradientLayer = CAGradientLayer.init()
        layer.colors = [UIColor.RGBMake(r: 0x2D, g: 0xA7, b: 0xE9).cgColor, UIColor.RGBMake(r: 0x15, g: 0x8F, b: 0xF1).cgColor]
        layer.locations = [0.3, 0.6, 1]
        layer.startPoint = CGPoint(x: 0, y: 1)
        layer.endPoint = CGPoint(x: 1, y: 0)
        layer.frame = frame
        view.layer.addSublayer(layer)
        //
        return view
    }
    
    // 创建渐变图片
    func drawBlueGradientView() -> UIImage {
        let size: CGSize = CGSize(width: ScreenWidth, height: NavigationBarHeight)
        let view = self.createBlueGradientView(size: size)
        //
        UIGraphicsBeginImageContext(size)
        view.drawHierarchy(in: CGRect(origin: CGPoint(), size: size), afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
}

