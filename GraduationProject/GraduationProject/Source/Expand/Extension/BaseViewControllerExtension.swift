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
    
    // 新增返回按钮 （箭头）
    @objc func addLeftBackButton() -> UIButton {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage(named: "ico_return_nav"), for: .normal)
        btn.backgroundColor = UIColor.RGBSameMake(value: 0xff, a: 0.3)
        btn.frame = CGRect(x: 10, y: (isiPhoneX ? 44 : 25), width: 40, height: 40)
        btn.xCornerRadius = 20
        btn.cMasksToBounds = true
        btn.addTarget(self, action: #selector(back), for: .touchUpInside)
        self.view.addSubview(btn)
        //
        return btn
    }
    
    // 新增关闭按钮（叉）
    @objc func addLeftCloseButton() {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage(named: "ico_quit_nav"), for: .normal)
        btn.frame = CGRect(x: 10, y: (isiPhoneX ? 44 : 25), width: 40, height: 40)
        btn.addTarget(self, action: #selector(back), for: .touchUpInside)
        self.view.addSubview(btn)
    }
    
    // 白色返回箭头 用于扫码
    func addLeftWhiteBackButton() {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage(named: "scanActivate_return_white"), for: .normal)
        btn.frame = CGRect(x: 10, y: (isiPhoneX ? 44 : 25), width: 40, height: 40)
        btn.xCornerRadius = 20
        btn.cMasksToBounds = true
        btn.addTarget(self, action: #selector(back), for: .touchUpInside)
        self.view.addSubview(btn)
    }
    
    @objc func backToMain() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

