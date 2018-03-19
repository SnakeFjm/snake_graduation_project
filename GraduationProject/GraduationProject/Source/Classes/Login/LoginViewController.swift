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
