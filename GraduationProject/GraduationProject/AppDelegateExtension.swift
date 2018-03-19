//
//  AppDelegateExtension.swift
//  renbo
//
//  Created by dev on 2017/12/20.
//  Copyright © 2017年 iAskDoc Technology. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import QMUIKit
import SVProgressHUD
import Bugly

extension AppDelegate {
    
    // =================================
    // MARK: 初始化一些组件的设置
    // =================================
    
    //
    func initSettings() {
        
        // QMUI
        QMUIConfiguration.sharedInstance()?.hidesBottomBarWhenPushedInitially = true
        QMUIConfiguration.sharedInstance()?.navBarTintColor = UIColor.RGBSameMake(value: 0x33)
        
        // SVProgressHUD
        SVProgressHUDSettings()
        
        // 检测本地是否已经登录
        UserManager.shared.checkUserLoginInfo()
        
    }
    
    // =================================
    // MARK: 监听通知
    // =================================
    
    func addNotifications() {
        // 监听登录状态
        NotificationCenter.default.addObserver(self, selector: #selector(changeRootViewController), name: K_LOGIN_STATUS_CHANGE, object: nil)
    }
    
    
    // ================================
    // MARK:
    // ================================
    
    
    
    // =================================
    // MARK: 更改主控制器
    // =================================
    
    @objc func changeRootViewController() {
        
        // 先判断是否需要更改
        if let rootVC = self.window?.rootViewController {
            if (UserManager.shared.isLogin && rootVC.isKind(of: MainViewController.classForCoder())) || (!UserManager.shared.isLogin && rootVC.isKind(of: LoginViewController.classForCoder())) {
                return
            }
        }

        if UserManager.shared.isLogin {
            // 已经登录
            let mainVC: MainViewController = MainViewController()
            self.window?.rootViewController = mainVC
            
        } else {
            // 还未登录
            let loginVC: LoginViewController = LoginViewController()
            let navController: QMUINavigationController = QMUINavigationController.init(rootViewController: loginVC)
            self.window?.rootViewController = navController
        }
        
        // 消除阴影
        self.window?.backgroundColor = UIColor.white
        
    }

    
}
