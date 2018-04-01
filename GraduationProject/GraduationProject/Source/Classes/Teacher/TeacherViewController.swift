
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
        HttpManager.shared.postRequest(apiName, parameters: parameters, encoding: JSONEncoding.default).responseJSON { [weak self] (response) in
            if let result = HttpManager.parseDataResponse(response) {
                //
                self?.reloadTableViewData()
            }
        }
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CourseTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CourseTableViewCell", for: indexPath) as! CourseTableViewCell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        self.push(TeacherCourseDetailViewController())
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func navBarRightBarButtonDidTouch(_ sender: Any) {
        self.push(AddTeacherCourseViewController())
    }
    

}
