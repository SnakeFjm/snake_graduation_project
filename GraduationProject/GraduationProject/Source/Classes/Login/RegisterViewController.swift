//
//  RegisterViewController.swift
//  GraduationProject
//
//  Created by Snake on 2018/3/22.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class RegisterViewController: BaseViewController {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var collegeTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!

    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var imageButton: UIButton!
    
    @IBOutlet weak var codeView: UIView!
    @IBOutlet weak var registerTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.title = "注册"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // =================================
    // MARK:
    // =================================
    
    @IBAction func chooseRoleButtonDidTouch(_ sender: Any) {
        let titleArray = ["学生", "老师"]
        showActionSheet(title: "请选择身份", otherTitles: titleArray) { (_, index) in
            if index == 0 {
                return
            }
            self.imageButton.isSelected = (index == 2)
            self.codeView.isHidden = !(index == 2)
            self.registerTopConstraint.constant = index == 2 ? 15 : -10
            self.roleLabel.text = titleArray[index-1]
        }
    }
    
    
    @IBAction func registerButtonDidTouch(_ sender: Any) {
        //
        if (self.idTextField.text?.isEmpty)! || (self.nameTextField.text?.isEmpty)! || (self.collegeTextField.text?.isEmpty)! || (self.passwordTextField.text?.isEmpty)! {
            return
        }
        let role: String = self.roleLabel.text!
        switch role {
        case "学生":
            self.register(code: "")
        case "教师":
            if (self.codeTextField.text?.isEmpty)! {
                return
            }
            self.register(code: self.codeTextField.text!)
        default:
            return
        }
    }
    
    // =================================
    // MARK:
    // =================================
    
    func register(code: String) {
        //
        let apiName = (code == "") ? "" : ""
        
        let id = self.idTextField.text!
        let name = self.nameTextField.text!
        let college = self.collegeTextField.text!
        let password = self.passwordTextField.text!
        var parameters: Parameters = ["id": id,
                                      "name": name,
                                      "college": college,
                                      "password": password]
        if code != "" {
            parameters.updateValue(code, forKey: "code")
        }
        //
        HttpManager.shared.postRequest(apiName, parameters: parameters, encoding: JSONEncoding.default).responseJSON { [weak self] (response) in
            if let _ = HttpManager.parseDataResponse(response) {
                //
                showSuccessTips("注册成功")
                self?.back()
            }
        }
    }

}
