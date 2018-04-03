//
//  StudentAddClassViewController.swift
//  GraduationProject
//
//  Created by Snake on 2018/3/26.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class StudentAddClassViewController: RefreshTableViewController {

    @IBOutlet var headerView: UIView!
    var courseJson: JSON = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.title = "加入班级"
        //
        self.registerCellNib(nibName: "SingleTableViewCell")
        self.tableView.tableHeaderView = self.headerView
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .singleLine
        //
        self.loadDataFromServer()
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
        let apiName = URLManager.course()
        //
        HttpManager.shared.postRequest(apiName).responseJSON { [weak self] (response) in
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
        let cell: SingleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SingleTableViewCell", for: indexPath) as! SingleTableViewCell
        
        cell.titleLabel.text = "课程名称"
        cell.contentLabel.text = self.dataArray[indexPath.row]["name"].stringValue
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        //
        showAlertController(title: "确定加入该班级吗", message: "", cancelTitle: "取消", confirmTitle: "确定") { (_, index) in
            //
            if index == 1 {
                //
                let courseId = self.dataArray[indexPath.row]["id"].stringValue
                let teacherId = self.dataArray[indexPath.row]["teacher_id"].stringValue
                self.addClass(courseId: courseId, teacherId: teacherId)
            }
        }
    }
    
    // =================================
    // MARK:
    // =================================
    
    func addClass(courseId: String, teacherId: String) {
        //
        let apiName = URLManager.student_course_add()
        let studentId = UserManager.shared.userModel.id
        let course_id = courseId
        let teacherId = teacherId
        let parameters: Parameters = ["course_id": courseId,
                                      "teacher_id": teacherId,
                                      "student_id": studentId]
        //
        HttpManager.shared.postRequest(apiName, parameters: parameters).responseJSON { [weak self] (response) in
            if let result = HttpManager.parseDataResponse(response) {
                //
                let status = result["status"].stringValue
                if status == "1" {
                    showSuccessTips("加入班级成功")
                } else {
                    showErrorTips("加入班级失败")
                }
            }
        }
    }

}
