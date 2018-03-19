//
//  SelectedTableViewController.swift
//  renbo
//
//  Created by dev on 2017/12/21.
//  Copyright © 2017年 iAskDoc Technology. All rights reserved.
//

import UIKit

class SelectedTableViewController: RefreshTableViewController {
    
    
    var isMultiSelected: Bool = false // 是否多选
    
    var selectedIndexPath: [IndexPath] = [] // 选择
    
    
    // =================================
    // MARK:
    // =================================
    
    convenience init(multiSelected: Bool = false) {
        self.init()
        //
        self.isMultiSelected = multiSelected
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //
        self.registerCellNib(nibName: "SelectedTableViewCell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SelectedTableViewCell = cellForCellIndentifier(indexPath: indexPath) as! SelectedTableViewCell
        
        cell.isItemSelected = self.isItemSelected(indexPath: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.updateItemSelectedState(indexPath: indexPath)
    }
    
    
    // =================================
    // MARK:
    // =================================
    
    
    // 该项是否被选中
    func isItemSelected(indexPath: IndexPath) -> Bool {
        if self.selectedIndexPath.contains(indexPath) {
            return true
        }
        return false
    }
    
    // 更新某项的选择状态
    func updateItemSelectedState(indexPath: IndexPath) {
        
        // 该项是否已经选中
        var state: Bool = self.isItemSelected(indexPath: indexPath)
        state = !state
        
        if state {
            // 选中
            self.itemBeSelected(indexPath: indexPath)
            
        } else {
            // 取消选择
            self.itemCancelSelected(indexPath: indexPath)
        }
        
        // 刷新列表
        self.reloadTableViewData()
    }
    
    
    // 新增某项
    func itemBeSelected(indexPath: IndexPath) {
        if self.isMultiSelected {
            // 多选
            self.selectedIndexPath.append(indexPath)
        } else {
            // 单选
            self.selectedIndexPath = []
            self.selectedIndexPath.append(indexPath)
        }
    }
    
    // 取消某项的选择
    func itemCancelSelected(indexPath: IndexPath) {
        guard let index: Int = self.selectedIndexPath.index(of: indexPath) else {
            return
        }
        self.selectedIndexPath.remove(at: index)
    }


}
