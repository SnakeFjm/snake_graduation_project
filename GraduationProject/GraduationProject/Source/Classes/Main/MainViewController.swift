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
    
    var studentNav: QMUINavigationController!
    var teacherNav: QMUINavigationController!
    var examNav: QMUINavigationController!
    var profileNav: QMUINavigationController!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        let role = UserManager.shared.userModel.role
        //
        self.initSubViewControllers(role: role)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // =================================
    // MARK:
    // =================================
    
    func initSubViewControllers(role: String) {
        //
        if role == "学生" {
            
        }
        let studentVC = StudentViewController()
        studentVC.hidesBottomBarWhenPushed = false
        self.studentNav = QMUINavigationController.init(rootViewController: studentVC)
        let studentItem = UITabBarItem.init(title: "签到", image: UIImage(named: "signIn"), selectedImage: UIImage(named: "signIn_selected"))
        studentItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.RGBSameMake(value: 0x66)], for: .normal)
        studentItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.RGBMake(r: 0x1B, g: 0x9D, b: 0xE3)], for: .selected)
        self.studentNav.tabBarItem = studentItem

        //
        let examVC = ExamViewController()
        examVC.hidesBottomBarWhenPushed = false
        self.examNav = QMUINavigationController.init(rootViewController: examVC)
        let examItem = UITabBarItem.init(title: "测验", image: UIImage(named: "exam"), selectedImage: UIImage(named: "exam_selected"))
        examItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.RGBSameMake(value: 0x66)], for: .normal)
        examItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.RGBMake(r: 0x1B, g: 0x9D, b: 0xE3)], for: .selected)
        self.examNav.tabBarItem = examItem

        //
        let profileVC = ProfileViewController()
        profileVC.hidesBottomBarWhenPushed = false
        profileNav = QMUINavigationController.init(rootViewController: profileVC)
        let profileItem = UITabBarItem.init(title: "我的", image: UIImage(named: "profile"), selectedImage: UIImage(named: "profile_selected"))
        profileItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.RGBSameMake(value: 0x66)], for: .normal)
        profileItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.RGBMake(r: 0x1B, g: 0x9D, b: 0xE3)], for: .selected)
        profileNav.tabBarItem = profileItem

        //
        self.viewControllers = [studentNav, examNav, profileNav]
    }


}





