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
    
    @IBOutlet weak var rememberPaswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //self.rememberPaswordButton.setImage(UIImage.init(named: "checkbox_1"), for: .normal)
        
        //是否自动登录
        self.autoLogin()

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
    
    func autoLogin() {
        
//        if !SessionManager.share.rememberPhone.isEmpty {
//            self.phoneTextField.text = SessionManager.share.rememberPhone
//        }
//
//        if SessionManager.share.isNeedRememberPassword {
//
//            self.rememberPaswordButton.setImage(UIImage.init(named: "checkbox_selected_1"), for: .normal)
//            SessionManager.share.isNeedRememberPassword = true
//
//            if !SessionManager.share.rememberPassword.isEmpty {
//                self.passwordTextField.text = SessionManager.share.rememberPassword
//            }
//        }
        
    }
    
    
    // =================================
    // MARK:
    // =================================

    @IBAction func loginButtonDidTouch(_ sender: UIButton) {
    
        
    }
    
    @IBAction func rememberPwdButtonDidTouch(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    func loginSuccessfully(phoneValue: String, pwdValue: String) {
        //
//        SessionManager.share.isLogin = true
//
//        SessionManager.share.rememberPhone = phoneValue
//
//        SessionManager.share.isNeedRememberPassword = self.rememberPaswordButton.isSelected
//
//        if self.rememberPaswordButton.isSelected {
//            SessionManager.share.rememberPassword = pwdValue
//        } else {
//            SessionManager.share.rememberPassword = ""
//        }
//        //
//        NotificationCenter.default.post(name: K_LOGIN_CHECK_STATUS, object: nil, userInfo: nil)
        
    }
}
