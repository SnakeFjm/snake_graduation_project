//
//  ProfileViewController.swift
//  GraduationProject
//
//  Created by Snake on 2018/3/22.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit

class ProfileViewController: RefreshTableViewController {

    @IBOutlet var headerView: UIView!
    
    var userModel: UserModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.title = "我的"
        self.titleView.tintColor = UIColor.white
        self.isHiddenNavigationBarShadowLine = true
        //
        self.navBarAddRightBarButton(image: UIImage.init(named: "profile_nav_setting")!)
        //
        self.userModel = UserManager.shared.userModel
        //
        self.dataArray = ["ID", "姓名", "学院", "身份"]
        // 注册tableView
        self.registerCellNib(nibName: "ProfileTableViewCell")
        //
        self.tableView.separatorStyle = .singleLine
        self.tableView.separatorColor = UIColor.init(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        //
        self.tableView.rowHeight = 56
        self.tableView.sectionHeaderHeight = 10
        self.tableView.tableHeaderView = self.headerView
        self.tableView.tableFooterView = UIView.init()
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //
        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //
        UIApplication.shared.statusBarStyle = .default
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.RGBSameMake(value: 0x33)]
        
    }
    
    override func hiddenNavBarShadowLine() {
        let image = UIImage.qmui_image(with: UIColor.init(red: 46/255, green: 46/255, blue: 46/255, alpha: 1), size: CGSize(width: ScreenWidth, height: NavigationBarHeight), cornerRadius: 0)
        self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProfileTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
        cell.titleLabel.text = self.dataArray[indexPath.row].stringValue
        switch indexPath.row {
        case 0:
            cell.contentLabel.text = self.userModel.id
        case 1:
            cell.contentLabel.text = self.userModel.name
        case 2:
            cell.contentLabel.text = self.userModel.college
        case 3:
            cell.contentLabel.text = self.userModel.role
        default:
            break
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func navBarRightBarButtonDidTouch(_ sender: Any) {
        self.push(SettingViewController())
    }

}
