
//
//  TeacherViewController.swift
//  GraduationProject
//
//  Created by Snake on 2018/3/22.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TeacherViewController: RefreshTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.title = "我的班级"
        //
        self.navBarAddRightBarButton(title: "创建班级")
        //
        self.registerCellNib(nibName: "CourseTableViewCell")
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
        let apiName = URLManager.teacher_course()
        let teacherId = UserManager.shared.userModel.id
        let parameters: Parameters = ["teacher_id": teacherId]
        //
        HttpManager.shared.postRequest(apiName, parameters: parameters).responseJSON { [weak self] (response) in
            if let result = HttpManager.parseDataResponse(response) {
                //
                self?.dataArray = result.arrayValue
                self?.reloadTableViewData()
            }
        }
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CourseTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CourseTableViewCell", for: indexPath) as! CourseTableViewCell
        
        cell.idLabel.text = "课程ID: " + self.dataArray[indexPath.row]["id"].stringValue
        cell.nameLabel.text = "课程名: " + self.dataArray[indexPath.row]["name"].stringValue
        cell.courseYearLabel.text = "学年: " + self.dataArray[indexPath.row]["course_year"].stringValue
        cell.timeLabel.text = "上课时间: " + self.dataArray[indexPath.row]["time"].stringValue
        cell.classroomLabel.text = "上课地点: " + self.dataArray[indexPath.row]["classroom"].stringValue
        cell.studentNumberLabel.text = "学生数: :" + self.dataArray[indexPath.row]["number"].stringValue
        cell.weekCountLabel.text = "周数: " + self.dataArray[indexPath.row]["week_count"].stringValue
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        let vc = TeacherCourseDetailViewController()
        vc.json = self.dataArray[indexPath.row]
        self.push(vc)
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func navBarRightBarButtonDidTouch(_ sender: Any) {
        self.push(AddTeacherCourseViewController())
    }
    

}
