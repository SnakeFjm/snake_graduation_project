//
//  StudentCourseDetailViewController.swift
//  GraduationProject
//
//  Created by Snake on 2018/3/28.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class StudentCourseDetailViewController: RefreshTableViewController {

    @IBOutlet var footerView: UIView!
    
    var course_id = ""
    var courseJson: JSON = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.title = "班级详情"
        //
        self.dataArray = ["课程ID", "课程名字", "周数", "上课时间", "地点", "教师名字"]
        //
        self.registerCellNib(nibName: "SingleTableViewCell")
        self.tableView.tableFooterView = self.footerView
        
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
        let apiName = URLManager.student_course_detail_info()
        let parameters: Parameters = ["course_id": self.course_id]
        //
        HttpManager.shared.postRequest(apiName, parameters: parameters).responseJSON { [weak self] (response) in
            if let result = HttpManager.parseDataResponse(response) {
                //
                self?.courseJson = result[0]
                self?.reloadTableViewData()
            }
        }
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SingleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SingleTableViewCell", for: indexPath) as! SingleTableViewCell
        
        cell.titleLabel.text = self.dataArray[indexPath.row].stringValue
        cell.contentLabel.text = self.contentOfCell(index: indexPath.row)
        
        return cell
    }
    
    // =================================
    // MARK:
    // =================================
    
    func contentOfCell(index: Int) -> String {
        switch index {
        case 0:
            return self.courseJson["course_id"].stringValue
        case 1:
            return self.courseJson["course_name"].stringValue
        case 2:
            return self.courseJson["week_count"].stringValue
        case 3:
            return self.courseJson["time"].stringValue
        case 4:
            return self.courseJson["classroom"].stringValue
        case 5:
            return self.courseJson["teacher_name"].stringValue
        default:
            return ""
        }
    }
    
    // =================================
    // MARK:
    // =================================
    
    @IBAction func SignInButtonDidTouch(_ sender: Any) {
        //
//        self.push(SignInViewController())
        let vc = ScanCodeViewController()
        vc.student_id = UserManager.shared.userModel.id
        vc.course_id = self.course_id
        self.push(vc)
    }
    
    @IBAction func classTestButtonDidTouch(_ sender: Any) {
        //
        let vc = StudentExamViewController()
        vc.course_id = self.course_id
        self.push(vc)
    }

}
