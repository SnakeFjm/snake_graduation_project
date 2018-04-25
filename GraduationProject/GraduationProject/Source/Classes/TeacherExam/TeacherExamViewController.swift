//
//  TeacherExamViewController.swift
//  GraduationProject
//
//  Created by Snake on 2018/3/23.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class TeacherExamViewController: RefreshTableViewController {

    var course_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.title = "测验"
        self.isHiddenNavigationBarShadowLine = true
        //
        self.registerCellNib(nibName: "ProfileTableViewCell")
        self.tableView.rowHeight = 56
        self.tableView.tableFooterView = UIView.init()
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
        let apiName = URLManager.teacher_test_all()
        let parameters: Parameters = ["course_id": self.course_id]
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
        let cell: ProfileTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
        //
        cell.titleLabel.text = "套题ID:  " + self.dataArray[indexPath.row]["week_number"].stringValue
        cell.contentLabel.isHidden = true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        //
        let week_number = self.dataArray[indexPath.row]["week_number"].stringValue
        let vc = TeacherExamDetailViewController()
        vc.course_id = course_id
        vc.week_number = self.dataArray[indexPath.row]["week_number"].stringValue
        self.push(vc)
    }
    
}
