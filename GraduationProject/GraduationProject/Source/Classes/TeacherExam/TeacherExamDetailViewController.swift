//
//  TeacherExamDetailViewController.swift
//  GraduationProject
//
//  Created by Snake on 2018/4/24.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class TeacherExamDetailViewController: RefreshTableViewController {
    
    var course_id = ""
    var week_number = ""
    
    var operate = "1"   // 0

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.title = "试题详情"
        self.isHiddenNavigationBarShadowLine = true
        //
        self.navBarAddRightBarButton()
        //
        self.registerCellNib(nibName: "TeacherExamDetailTableViewCell")
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = .singleLine
        self.tableView.tableFooterView = UIView()
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
        let apiName = URLManager.teacher_test_all_detail()
        let parameters: Parameters = ["course_id": self.course_id,
                                      "week_number": self.week_number]
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
        let cell: TeacherExamDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TeacherExamDetailTableViewCell", for: indexPath) as! TeacherExamDetailTableViewCell
        //
        cell.questionLabel.text = "问题：" + self.dataArray[indexPath.row]["question"].stringValue
        cell.answerLabel.text = "答案：" + self.dataArray[indexPath.row]["answer"].stringValue
        
        return cell
    }
    
    // =================================
    // MARK:
    // =================================
    
    func navBarAddRightBarButton() {
        //
        let openButton = UIBarButtonItem.init(title: "开启", style: .plain, target: self, action: #selector(openButtonDidTouch))
        let closeButton = UIBarButtonItem.init(title: "关闭", style: .plain, target: self, action: #selector(closeButtonDidTouch))
        self.navigationItem.rightBarButtonItems = [openButton, closeButton]
    }
    
    @objc func openButtonDidTouch() {
        showAlertController(title: "是否开启该试题", message: "", cancelTitle: "取消", confirmTitle: "确定", completion: { (_, index) in
            if index == 1 {
                self.operate = "1"
                self.switchExam()
            }
        })
    }
    
    @objc func closeButtonDidTouch() {
        showAlertController(title: "是否关闭该试题", message: "", cancelTitle: "取消", confirmTitle: "确定", completion: { (_, index) in
            if index == 1 {
                self.operate = "0"
                self.switchExam()
            }
        })
    }
    
    func switchExam() {
        //
        let apiName = URLManager.teacher_test_open_close()
        let parameters: Parameters = ["course_id": self.course_id,
                                      "week_number": self.week_number,
                                      "operate": self.operate]
        //
        HttpManager.shared.putRequest(apiName, parameters: parameters).responseJSON { [weak self] (response) in
            if let result = HttpManager.parseDataResponse(response) {
                //
                let status = result["status"].stringValue
                if status == "1" {
                    if self?.operate == "1" {
                        showSuccessTips("开启成功")
                    } else {
                        showSuccessTips("关闭成功")
                    }
                }
            }
        }
    }

}
