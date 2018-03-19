//
//  FoldTableViewController.swift
//  renbo
//
//  Created by dev on 2017/12/21.
//  Copyright © 2017年 iAskDoc Technology. All rights reserved.
//

import UIKit

class FoldTableViewController: RefreshTableViewController {
    
    
    var foldArray: [Bool] = [] // 收缩标志
    
    // =================================
    // MARK:
    // =================================

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        self.registerHeaderFooterNib(nibName: FoldTableHeaderView.identifier)
        self.tableView.estimatedSectionHeaderHeight = 50
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func reloadTableViewData() {
        foldArray = [Bool].init(repeating: false, count: self.dataArray.count)
        //
        super.reloadTableViewData()
    }
    
    
    // =================================
    // MARK:
    // =================================
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let fold = self.foldArray[section]
        if fold {
            return 0
        } else {
            if let arr: Array = self.dataArray[section].array {
                return arr.count
            } else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view: FoldTableHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: self.headerFooterIndentifier) as! FoldTableHeaderView
        //
        view.foldState = self.foldArray[section]
        //
        view.completion = {
            [weak self] (state) in
            self?.foldArray[section] = state
            self?.tableView.beginUpdates()
            self?.tableView.reloadSections([section], with: .automatic)
            self?.tableView.endUpdates()
        }
        
        return view
    }
    
    

}
