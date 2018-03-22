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

    @IBAction func loginButtonDidTouch(_ sender: UIButton) {
        //
        let apiName = URLManager.login()
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
                    self?.loginSuccessfully(phoneValue: id, pwdValue: password)
                    
                } else {
                    showErrorTips("账号或者密码不正确")
                }
            }
        }
        
    }
    
    func loginSuccessfully(phoneValue: String, pwdValue: String) {
        
        let dict = ["id": phoneValue, "password": pwdValue]
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
