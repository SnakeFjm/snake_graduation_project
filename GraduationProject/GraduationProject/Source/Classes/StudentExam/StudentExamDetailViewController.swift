//
//  StudentExamDetailViewController.swift
//  GraduationProject
//
//  Created by Snake on 2018/4/24.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class StudentExamDetailViewController: RefreshTableViewController {

    var course_id = ""
    var week_number = ""
    
    var answerArray: [String] = []
    var record: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.title = "试题详情"
        self.isHiddenNavigationBarShadowLine = true
        //
        self.navBarAddRightBarButton(title: "提交")
        //
        self.registerCellNib(nibName: "StudentExamDetailTableViewCell")
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
        let apiName = URLManager.student_test()
        let parameters: Parameters = ["course_id": self.course_id,
                                      "week_number": self.week_number]
        //
        HttpManager.shared.postRequest(apiName, parameters: parameters).responseJSON { [weak self] (response) in
            if let result = HttpManager.parseDataResponse(response) {
                //
                self?.dataArray = result.arrayValue
                let count = self?.dataArray.count ?? 0
                self?.answerArray = [String].init(repeating: "", count: count)
                //
                self?.reloadTableViewData()
            }
        }
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StudentExamDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "StudentExamDetailTableViewCell", for: indexPath) as! StudentExamDetailTableViewCell
        //
        cell.questionLabel.text = "问题：" + self.dataArray[indexPath.row]["question"].stringValue
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        //
        let cell: StudentExamDetailTableViewCell  = tableView.cellForRow(at: indexPath) as! StudentExamDetailTableViewCell
        let editor: TextFieldEditorViewController = TextFieldEditorViewController.init(aContent: "", aPlaceholder: "请输入答案", aTitle: "") {
            [weak self] (content) in
            if content != nil {
                cell.answerTextField.text = content
                self?.answerArray[indexPath.row] = content ?? ""
            }
        }
        self.push(editor)
    }
    
    // =================================
    // MARK:
    // =================================
    
    func updateAnswer() {
        //
        let editor: TextFieldEditorViewController = TextFieldEditorViewController.init(aContent: "", aPlaceholder: "请输入课程名", aTitle: "课程名") {
            [weak self] (content) in
            if content != nil {
                
            }
            self?.reloadTableViewData()
        }
        self.push(editor)
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func navBarRightBarButtonDidTouch(_ sender: Any) {
        for i in 0..<self.dataArray.count {
            if self.answerArray[i] == self.dataArray[i]["answer"].stringValue {
                self.record += 5
            }
        }
        //
        self.commitAnswer()
    }
    
    func commitAnswer() {
        //
        let apiName = URLManager.student_record()
        let student_id = UserManager.shared.userModel.id
        let parameters: Parameters = ["course_id": self.course_id,
                                      "student_id": student_id,
                                      "record": self.record]
        //
        HttpManager.shared.putRequest(apiName, parameters: parameters).responseJSON { [weak self] (response) in
            if let result = HttpManager.parseDataResponse(response) {
                //
                let status = result["status"].intValue
                if status > 0 {
                    showSuccessTips("提交成功")
                } else {
                    showErrorTips("提交失败")
                }
            }
        }
    }
    
}
