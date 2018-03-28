//
//  StudentSignInDetailViewController.swift
//  GraduationProject
//
//  Created by Snake on 2018/3/28.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit

class StudentSignInDetailViewController: RefreshTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.title = "签到详情"
        self.registerCellNib(nibName: "StudentSignInDetailTableViewCell")
        self.tableView.separatorStyle = .singleLine
        self.tableView.estimatedRowHeight = 50
        self.tableView.tableFooterView = UIView()
        
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
        let apiName = ""
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StudentSignInDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "StudentSignInDetailTableViewCell", for: indexPath) as! StudentSignInDetailTableViewCell
        
        cell.dateLabel.text = ""
        cell.signInSituationLabel.text = ""
        
        return cell
    }
    
}
