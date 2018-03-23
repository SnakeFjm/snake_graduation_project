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

    @IBOutlet var headerView: UIView!
    @IBOutlet weak var courseSegmented: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.courseSegmented.selectedSegmentIndex = 0
        self.courseSegmented.addTarget(self, action: #selector(segmentedControChanged), for: UIControlEvents.valueChanged)
        //
        self.title = "班级详情"
        self.registerCellNib(nibName: "")
        self.tableView.separatorStyle = .singleLine
        self.tableView.estimatedRowHeight = 50
        self.tableView.tableHeaderView = self.headerView
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
    
    @objc func segmentedControChanged() {
        switch self.courseSegmented.selectedSegmentIndex {
        case 0:
            break
        case 1:
            break
        case 2:
            break
        default:
            break
        }
    }

}
