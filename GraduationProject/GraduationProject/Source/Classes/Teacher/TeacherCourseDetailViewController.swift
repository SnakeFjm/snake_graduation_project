//
//  TeacherCourseDetailViewController.swift
//  GraduationProject
//
//  Created by Snake on 2018/3/23.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class TeacherCourseDetailViewController: RefreshTableViewController {
    
    @IBOutlet var footerView: UIView!
    
    var json: JSON = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.title = "班级详情"
        //
        self.dataArray = ["课程ID", "课程名", "学年", "上课时间", "上课地点", "学生数", "周数"]
        //
        self.registerCellNib(nibName: "SingleTableViewCell")
        self.tableView.tableFooterView = self.footerView
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SingleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SingleTableViewCell", for: indexPath) as! SingleTableViewCell
        
        cell.titleLabel.text = self.dataArray[indexPath.row].stringValue
        cell.contentLabel.text = contentOfCell(index: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    // =================================
    // MARK:
    // =================================
    
    func contentOfCell(index: Int) -> String {
        //
        switch index {
        case 0:
            return self.json["id"].stringValue
        case 1:
            return self.json["name"].stringValue
        case 2:
            return self.json["course_year"].stringValue
        case 3:
            return self.json["time"].stringValue
        case 4:
            return self.json["classroom"].stringValue
        case 5:
            return self.json["number"].stringValue
        case 6:
            return self.json["week_count"].stringValue
        default:
            return ""
        }
    }
    
    // =================================
    // MARK:
    // =================================
    
    @IBAction func checkSignInSituationButtonDidTouch(_ sender: Any) {
        //
        let course_id = self.json["id"].stringValue
        let vc = StudentSignInSituationViewController()
        vc.course_id = course_id
        self.push(vc)
    }
    
    @IBAction func classTestButtonDidTouch(_ sender: Any) {
        //
//        self.navigationController?.popToRootViewController(animated: false)
//        let testVC = self.navigationController?.tabBarController?.viewControllers![1]
//        self.tabBarController?.selectedViewController = testVC!
        self.tabBarController?.selectedIndex = 1
    }
    

}
