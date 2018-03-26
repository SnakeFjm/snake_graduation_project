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
        self.addNavRightButtons()
        //
        self.registerCellNib(nibName: "StudentCourseTableViewCell")
        self.tableView.separatorStyle = .singleLine
        self.tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func loadDataFromServer() {
        //
        let apiName = ""
        HttpManager.shared.getRequest(apiName).responseJSON { [weak self] (response) in
            if let result = HttpManager.parseDataResponse(response) {
                //
            }
        }
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StudentCourseTableViewCell = tableView.dequeueReusableCell(withIdentifier: "StudentCourseTableViewCell", for: indexPath) as! StudentCourseTableViewCell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        //
        
    }
    
    // =================================
    // MARK:
    // =================================
    
    // 签到 加入班级 按钮
    func addNavRightButtons() {
    
        let signInButton = UIBarButtonItem.init(title: "签到", style: .plain, target: self, action: #selector(signInButtonDidTouch))
        let addClassButton = UIBarButtonItem.init(title: "加入班级", style: .plain, target: self, action: #selector(addClassButtonDidTouch))
        //
        self.navigationItem.rightBarButtonItems = [signInButton, addClassButton]
    }
    
    // =================================
    // MARK:
    // =================================
    
    @objc func signInButtonDidTouch() {
        self.push(SignInViewController())
    }

    @objc func addClassButtonDidTouch() {
        self.push(StudentAddClassViewController())
    }
}
