//
//  StudentViewController.swift
//  GraduationProject
//
//  Created by Snake on 2018/3/22.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class StudentViewController: RefreshTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.title = "我的课程"
        //
        self.addNavRightButtons()
        //
        self.registerCellNib(nibName: "StudentCourseTableViewCell")
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = .singleLine
        self.tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //
        self.loadDataFromServer()
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func loadDataFromServer() {
        //
        let apiName = URLManager.student_course_easy_info()
        let student_id = UserManager.shared.userModel.id
        let parameters: Parameters = ["student_id": student_id]
        //
        HttpManager.shared.postRequest(apiName, parameters: parameters).responseJSON { [weak self] (response) in
            if let result = HttpManager.parseDataResponse(response) {
                //
                self?.dataArray = result.arrayValue
                //
                self?.reloadTableViewData()
            }
        }
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StudentCourseTableViewCell = tableView.dequeueReusableCell(withIdentifier: "StudentCourseTableViewCell", for: indexPath) as! StudentCourseTableViewCell
        //
        cell.nameLabel.text = self.dataArray[indexPath.row]["name"].stringValue
        cell.teacherNameLabel.text = self.dataArray[indexPath.row]["teaName"].stringValue
        cell.timeLabel.text = self.dataArray[indexPath.row]["time"].stringValue
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        //
        let course_id = self.dataArray[indexPath.row]["course_id"].stringValue
        let vc = StudentCourseDetailViewController()
        vc.course_id = course_id
        self.push(vc)
    }
    
    // =================================
    // MARK:
    // =================================
    
    // 签到 加入班级 按钮
    func addNavRightButtons() {
    
//        let signInButton = UIBarButtonItem.init(title: "签到", style: .plain, target: self, action: #selector(signInButtonDidTouch))
        let addClassButton = UIBarButtonItem.init(title: "加入班级", style: .plain, target: self, action: #selector(addClassButtonDidTouch))
        //
        self.navigationItem.rightBarButtonItem = addClassButton
//        self.navigationItem.rightBarButtonItems = [signInButton, addClassButton]
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
