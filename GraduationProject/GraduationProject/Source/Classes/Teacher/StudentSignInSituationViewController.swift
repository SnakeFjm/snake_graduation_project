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

}
