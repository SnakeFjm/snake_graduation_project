//
//  LoginViewController.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/11/6.
//  Copyright © 2017年 Snake. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: BaseViewController {

    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var imageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.isHiddenNavigationBarShadowLine = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // =================================
    // MARK:
    // =================================
    
    @IBAction func chooseRoleButtonDidTouch(_ sender: Any) {
        //
        let titleArray = ["学生", "老师"]
        showActionSheet(title: "请选择身份", otherTitles: titleArray) { (_, index) in
            if index == 0 {
                return
            }
            self.roleLabel.text = titleArray[index-1]
        }
    }
    
    @IBAction func registerButtonDidTouch(_ sender: Any) {
        //
        self.push(RegisterViewController())
    }

    @IBAction func loginButtonDidTouch(_ sender: UIButton) {
        //
        if (self.roleLabel.text?.isEmpty)! {
            return
        }
        //
        let apiName = (self.roleLabel.text! == "学生") ? URLManager.login_student() : URLManager.login_teacher()
        let id = self.phoneTextField.text!
        let password = self.passwordTextField.text!
        let parameters: Parameters = ["id": id,
                                    "password": password]
        //
        HttpManager.shared.postRequest(apiName, parameters: parameters).responseJSON { [weak self] (response) in
            if let result = HttpManager.parseDataResponse(response) {
                let status = result["status"].stringValue
                if status == "1" {
                    //
                    self?.loginSuccessfully()
                } else if status == "0" {
                    showErrorTips("密码不正确")
                } else if status == "-1" {
                    showErrorTips("账号不存在")
                }
            }
        }
        
    }
    
    func loginSuccessfully() {
        //
        let id = self.phoneTextField.text!
        let password = self.passwordTextField.text!
        let role = self.roleLabel.text!
        //
        let dict = ["id": id, "password": password, "role": role]
        if let model = UserModel(JSON: dict) {
            //
            UserManager.shared.saveUserModel(model: model)
        }
        //
        showSuccessTips("登录成功")
        //
        NotificationCenter.default.post(name: K_LOGIN_STATUS_CHANGE, object: nil)
    }
    
}
