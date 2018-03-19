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
    
    var homePageNav: QMUINavigationController!
    var contactNav: QMUINavigationController!
    var articleNav: QMUINavigationController!
    var profileNav: QMUINavigationController!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //
//        self.initSubViewControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // =================================
    // MARK:
    // =================================
    
//    func initSubViewControllers() {
//        //
//        let homePageVC = HomePageViewController()
//        homePageVC.hidesBottomBarWhenPushed = false
//        homePageNav = QMUINavigationController.init(rootViewController: homePageVC)
//        let homeItem = UITabBarItem.init(title: "首页", image: UIImage(named: "tab_home"), selectedImage: UIImage(named: "tab_home_pre"))
//        homeItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.RGBSameMake(value: 0x66)], for: .normal)
//        homeItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.RGBMake(r: 0x1B, g: 0x9D, b: 0xE3)], for: .selected)
//        homePageNav.tabBarItem = homeItem
//
//        //
//        let contactVC = ContactViewController()
//        contactVC.hidesBottomBarWhenPushed = false
//        contactNav = QMUINavigationController.init(rootViewController: contactVC)
//        let contactItem = UITabBarItem.init(title: "联系人", image: UIImage(named: "tab_contact"), selectedImage: UIImage(named: "tab_contact_pre"))
//        contactItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.RGBSameMake(value: 0x66)], for: .normal)
//        contactItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.RGBMake(r: 0x1B, g: 0x9D, b: 0xE3)], for: .selected)
//        contactNav.tabBarItem = contactItem
//
//        //
//        let articleVC = ArticleViewController()
//        articleVC.hidesBottomBarWhenPushed = false
//        articleNav = QMUINavigationController.init(rootViewController: articleVC)
//        let articleItem = UITabBarItem.init(title: "资讯文章", image: UIImage(named: "tab_article"), selectedImage: UIImage(named: "tab_article_pre"))
//        articleItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.RGBSameMake(value: 0x66)], for: .normal)
//        articleItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.RGBMake(r: 0x1B, g: 0x9D, b: 0xE3)], for: .selected)
//        articleNav.tabBarItem = articleItem
//
//        //
//        let profileVC = ProfileViewController()
//        profileVC.hidesBottomBarWhenPushed = false
//        profileNav = QMUINavigationController.init(rootViewController: profileVC)
//        let profileItem = UITabBarItem.init(title: "个人中心", image: UIImage(named: "tab_profile"), selectedImage: UIImage(named: "tab_profile_pre"))
//        profileItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.RGBSameMake(value: 0x66)], for: .normal)
//        profileItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.RGBMake(r: 0x1B, g: 0x9D, b: 0xE3)], for: .selected)
//        profileNav.tabBarItem = profileItem
//
//        //
//        self.viewControllers = [homePageNav, contactNav, articleNav, profileNav]
//    }


}





