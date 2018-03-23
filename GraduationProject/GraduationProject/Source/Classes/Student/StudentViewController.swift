//
//  StudentViewController.swift
//  GraduationProject
//
//  Created by Snake on 2018/3/22.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit

class StudentViewController: RefreshTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.title = "我的课程"
        //
        self.navBarAddRightBarButton(title: "加入班级")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func loadDataFromServer() {
        
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func navBarRightBarButtonDidTouch(_ sender: Any) {
        
    }

}
