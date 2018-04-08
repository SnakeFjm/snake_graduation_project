//
//  StudentSignInSituationViewController.swift
//  GraduationProject
//
//  Created by Snake on 2018/3/28.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class StudentSignInSituationViewController: RefreshTableViewController {

    var course_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.title = "签到情况"
        self.registerCellNib(nibName: "StudentSignInSituationTableViewCell")
        self.tableView.separatorStyle = .singleLine
        self.tableView.estimatedRowHeight = 50
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
        let apiName = URLManager.teacher_call_name_count()
        let parameters: Parameters = ["course_id": self.course_id]
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
        let cell: StudentSignInSituationTableViewCell = tableView.dequeueReusableCell(withIdentifier: "StudentSignInSituationTableViewCell", for: indexPath) as! StudentSignInSituationTableViewCell
        //
        cell.nameLabel.text = self.dataArray[indexPath.row]["student_name"].stringValue
        cell.signInCountLabel.text = self.dataArray[indexPath.row]["sum"].stringValue
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        let vc = StudentSignInDetailViewController()
        vc.course_id = self.course_id
        vc.student_id = self.dataArray[indexPath.row]["student_id"].stringValue
        self.push(vc)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction.init(style: UITableViewRowActionStyle.destructive, title: "删除") { (_, _) in
            showAlertController(title: "是否删除该学生", message: "", cancelTitle: "取消", confirmTitle: "确定", completion: { (_, index) in
                if index == 1 {
                    let studentId = self.dataArray[indexPath.row]["student_id"].stringValue
                    self.deleteStudent(studentId: studentId)
                }
            })
        }
        
        return [deleteAction]
    }
    
    // =================================
    // MARK:
    // =================================
    
    func deleteStudent(studentId: String) {
        let apiName = URLManager.teacher_delete_student()
        let parameters: Parameters = ["student_id": studentId,
                                      "course_id": self.course_id]
        //
        HttpManager.shared.deleteRequest(apiName, parameters: parameters).responseJSON { (response) in
            if let result = HttpManager.parseDataResponse(response) {
                let status = result["status"].intValue
                if status > 1 {
                    showSuccessTips("删除成功")
                    self.loadDataFromServer()
                } else {
                    showErrorTips("删除失败")
                }
            }
        }
    }

}
