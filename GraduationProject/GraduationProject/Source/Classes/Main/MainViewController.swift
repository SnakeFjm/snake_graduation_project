//
//  MainViewController.swift
//  renbo
//
//  Created by dev on 2017/12/20.
//  Copyright © 2017年 iAskDoc Technology. All rights reserved.
//

import UIKit
import QMUIKit

class MainViewController: UITabBarController {
    
    var SignInNav: QMUINavigationController!
    var ExamNav: QMUINavigationController!
    var profileNav: QMUINavigationController!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.initSubViewControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // =================================
    // MARK:
    // =================================
    
    func initSubViewControllers() {
        //
        let SignInVC = SignInViewController()
        SignInVC.hidesBottomBarWhenPushed = false
        self.SignInNav = QMUINavigationController.init(rootViewController: SignInVC)
        let signInItem = UITabBarItem.init(title: "签到", image: UIImage(named: "signIn"), selectedImage: UIImage(named: "signIn_selected"))
        signInItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.RGBSameMake(value: 0x66)], for: .normal)
        signInItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.RGBMake(r: 0x1B, g: 0x9D, b: 0xE3)], for: .selected)
        self.SignInNav.tabBarItem = signInItem

        //
        let examVC = ExamViewController()
        examVC.hidesBottomBarWhenPushed = false
        self.ExamNav = QMUINavigationController.init(rootViewController: examVC)
        let examItem = UITabBarItem.init(title: "测验", image: UIImage(named: "exam"), selectedImage: UIImage(named: "exam_selected"))
        examItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.RGBSameMake(value: 0x66)], for: .normal)
        examItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.RGBMake(r: 0x1B, g: 0x9D, b: 0xE3)], for: .selected)
        self.ExamNav.tabBarItem = examItem

        //
        let profileVC = ProfileViewController()
        profileVC.hidesBottomBarWhenPushed = false
        profileNav = QMUINavigationController.init(rootViewController: profileVC)
        let profileItem = UITabBarItem.init(title: "我的", image: UIImage(named: "profile"), selectedImage: UIImage(named: "profile_selected"))
        profileItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.RGBSameMake(value: 0x66)], for: .normal)
        profileItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.RGBMake(r: 0x1B, g: 0x9D, b: 0xE3)], for: .selected)
        profileNav.tabBarItem = profileItem

        //
        self.viewControllers = [SignInNav, ExamNav, profileNav]
    }


}





