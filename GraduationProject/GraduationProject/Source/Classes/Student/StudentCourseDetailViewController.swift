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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.title = "班级详情"
        //
        self.dataArray = ["课程ID", "课程名字", "学年", "上课时间", "地点", "教师名字"]
        //
        self.registerCellNib(nibName: "SingleTableViewCell")
        self.tableView.separatorStyle = .singleLine
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
        cell.contentLabel.text = ""
        
        return cell
    }
    
    // =================================
    // MARK:
    // =================================
    
    @IBAction func SignInButtonDidTouch(_ sender: Any) {
        //
        self.push(SignInViewController())
    }
    
    @IBAction func classTestButtonDidTouch(_ sender: Any) {
        //
        
    }

}
