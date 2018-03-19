//
//  SessionManager.swift
//  FoodDetect
//
//  Created by dev on 2017/11/29.
//  Copyright © 2017年 iAskDoc Technology. All rights reserved.
//

import Foundation


class UserManager {
    
    static let shared: UserManager = UserManager()

    var isLogin: Bool = false
    
    var userModel: UserModel! {
        didSet {
            // 保存登录状态
            self.isLogin = (userModel != nil)
        }
    }
    
    
    // =================================
    // MARK:
    // =================================
    
    // 保存用户登录信息
    func saveUserModel(model: UserModel) {
        self.userModel = model
        //
        if let jsonString: String = self.userModel.toJSONString() {
            UserDefaults.standard.set(jsonString, forKey: K_USER_DEFAULT_LOGIN_INFOMATION)
            UserDefaults.standard.synchronize()
        }
    }
    
    func removeUserModel() {
        self.userModel = nil
        //
        UserDefaults.standard.removeObject(forKey: K_USER_DEFAULT_LOGIN_INFOMATION)
        UserDefaults.standard.synchronize()
    }
    
    
    // 检查用户登录信息
    func checkUserLoginInfo() {
        //
        if let jsonString: String = UserDefaults.standard.string(forKey: K_USER_DEFAULT_LOGIN_INFOMATION) {
            if let model: UserModel = UserModel(JSONString: jsonString) {
                //
                self.userModel = model
                debugPrint(jsonString)
            }
        }
    }
        
}
