//
//  StudentSignInSituationViewController.swift
//  GraduationProject
//
//  Created by Snake on 2018/3/28.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit

class StudentSignInSituationViewController: RefreshTableViewController {

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
        let apiName = ""
        
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StudentSignInSituationTableViewCell = tableView.dequeueReusableCell(withIdentifier: "StudentSignInSituationTableViewCell", for: indexPath) as! StudentSignInSituationTableViewCell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        self.push(StudentSignInDetailViewController())
    }

}
