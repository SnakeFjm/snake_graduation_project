//
//  StudentSignInDetailViewController.swift
//  GraduationProject
//
//  Created by Snake on 2018/3/28.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class StudentSignInDetailViewController: RefreshTableViewController {

    var student_id = ""
    var course_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.title = "签到详情"
        self.registerCellNib(nibName: "StudentSignInDetailTableViewCell")
        self.tableView.separatorStyle = .singleLine
        self.tableView.estimatedRowHeight = 50
        self.tableView.tableFooterView = UIView()
        
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
        let apiName = URLManager.teacher_call_name_detail()
        let parameters: Parameters = ["course_id": self.course_id,
                                      "student_id": self.student_id]
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
        let cell: StudentSignInDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "StudentSignInDetailTableViewCell", for: indexPath) as! StudentSignInDetailTableViewCell
        
        cell.dateLabel.text = "时间: " + self.dataArray[indexPath.row]["call_time"].stringValue
        cell.signInSituationLabel.text = (self.dataArray[indexPath.row]["is_call"].stringValue == "true") ? "是" : "否"
        
        return cell
    }
    
}
