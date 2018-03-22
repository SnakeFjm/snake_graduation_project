//
//  SettingViewController.swift
//  GraduationProject
//
//  Created by Snake on 2018/3/22.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit

class SettingViewController: RefreshTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.title = "设置"
        //
        self.registerCellNib(nibName: SingleItemTableViewCell.identifier)
        self.tableView.estimatedRowHeight = 50
        //
        self.dataArray = ["修改密码", "退出登录"]
        self.reloadTableViewData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // =================================
    // MARK:
    // =================================
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SingleItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: SingleItemTableViewCell.identifier, for: indexPath) as! SingleItemTableViewCell
        //
        cell.item.isHiddenLeftIcon = true
        cell.item.isHiddenRightIcon = false
        cell.item.title = self.dataArray[indexPath.row].stringValue
        cell.item.content = ""
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        //
        switch indexPath.row {
        case 0: // 修改密码
            let alterVC = AlterPasswordViewController()
            self.push(alterVC)
        case 1:
            //
            showAlertController(title: "是否退出登录?", message: "", completion: { (action, index) in
                if index == 1 {
                    // 清除信息
                    UserManager.shared.removeUserModel()
                    // 通知状态切换
                    NotificationCenter.default.post(name: K_LOGIN_STATUS_CHANGE, object: false)
                }
            })
        default:
            break
        }
    }

}
