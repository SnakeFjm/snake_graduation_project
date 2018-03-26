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
    
    var homeNavController: UINavigationController!
    var studentVC: StudentViewController!
    var teacherVC: TeacherViewController!
    
    var examNavController: UINavigationController!
    var studentExamVC: StudentExamViewController!
    var teacherExamVC: TeacherExamViewController!
    
    var profileNav: UINavigationController!
    

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
            self.studentVC = StudentViewController()
            self.studentVC.hidesBottomBarWhenPushed = false
            //
            self.studentExamVC = StudentExamViewController()
            self.studentExamVC.hidesBottomBarWhenPushed = false
        } else {    // if role == "教师"
            self.teacherVC = TeacherViewController()
            self.teacherVC.hidesBottomBarWhenPushed = false
            //
            self.teacherExamVC = TeacherExamViewController()
            self.teacherExamVC.hidesBottomBarWhenPushed = false
        }
        self.homeNavController = UINavigationController.init(rootViewController: (role == "学生") ? self.studentVC :self.teacherVC)
        let homeItem = UITabBarItem.init(title: "签到", image: UIImage(named: "signIn"), selectedImage: UIImage(named: "signIn_selected"))
        homeItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.RGBSameMake(value: 0x66)], for: .normal)
        homeItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.RGBMake(r: 0x1B, g: 0x9D, b: 0xE3)], for: .selected)
        self.homeNavController.tabBarItem = homeItem

        //
        self.examNavController = UINavigationController.init(rootViewController: (role == "学生") ? self.studentExamVC :self.teacherExamVC)
        let examItem = UITabBarItem.init(title: "测验", image: UIImage(named: "exam"), selectedImage: UIImage(named: "exam_selected"))
        examItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.RGBSameMake(value: 0x66)], for: .normal)
        examItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.RGBMake(r: 0x1B, g: 0x9D, b: 0xE3)], for: .selected)
        self.examNavController.tabBarItem = examItem

        //
        let profileVC = ProfileViewController()
        profileVC.hidesBottomBarWhenPushed = false
        profileNav = QMUINavigationController.init(rootViewController: profileVC)
        let profileItem = UITabBarItem.init(title: "我的", image: UIImage(named: "profile"), selectedImage: UIImage(named: "profile_selected"))
        profileItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.RGBSameMake(value: 0x66)], for: .normal)
        profileItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.RGBMake(r: 0x1B, g: 0x9D, b: 0xE3)], for: .selected)
        profileNav.tabBarItem = profileItem

        //
        self.viewControllers = [homeNavController, examNavController, profileNav]
    }


}





