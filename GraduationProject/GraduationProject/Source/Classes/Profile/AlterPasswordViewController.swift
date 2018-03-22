//
//  AlterPasswordViewController.swift
//  GraduationProject
//
//  Created by Snake on 2018/3/22.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AlterPasswordViewController: BaseViewController {

    @IBOutlet weak var originTextField: UITextField!
    @IBOutlet weak var newTextField: UITextField!
    @IBOutlet weak var againConfirmTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.title = "修改密码"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // =================================
    // MARK:
    // =================================
    
    @IBAction func alterPasswordButtonDidTouch(_ sender: Any) {
        //
        if (self.originTextField.text?.isEmpty)! || (self.newTextField.text?.isEmpty)! || (self.againConfirmTextField.text?.isEmpty)! {
            return
        }
        //
        if self.newTextField.text! == self.againConfirmTextField.text! {
            //
            let apiName = ""
            let parameters: Parameters = ["password": self.newTextField.text!]
            HttpManager.shared.postRequest(apiName, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { (response) in
                if let _ = HttpManager.parseDataResponse(response) {
                    //
                    showSuccessTips("修改成功，请重新登录")
                    // 清除信息
                    UserManager.shared.removeUserModel()
                    // 通知状态切换
                    NotificationCenter.default.post(name: K_LOGIN_STATUS_CHANGE, object: false)
                }
            })
        } else {
            showAlertController(title: "两次输入的密码不正确", message: "")
        }
    }
    

}
