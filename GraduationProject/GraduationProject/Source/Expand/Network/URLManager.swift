//
//  URLManager.swift
//  FoodDetect
//
//  Created by dev on 2017/11/29.
//  Copyright © 2017年 iAskDoc Technology. All rights reserved.
//

import Foundation


class URLManager {
    

    static func apiPath(_ apiName: String, version: Int = 1) -> String {
        var result = BaseSettingManager.shared.hostName() 
        if apiName.hasPrefix("/") {
            result = result + apiName
        } else {
            result = result + "/" + apiName
        }
        return result
    }
    
    // 返回ImageView地址
    static func domainSourcePath(_ path: String) -> String {
        if path.hasPrefix("http") || path.hasPrefix("www.") {
            return path
        }
        var result = BaseSettingManager.shared.hostName()
        if path.hasPrefix("/") {
            result = result + path
        } else {
            result = result + "/" + path
        }
        return result
    }
    
    // =================================
    // MARK: 登录
    // =================================
    
    static func login_student() -> String {
        return apiPath("/login/student")
    }
    
    static func login_teacher() -> String {
        return apiPath("/login/teacher")
    }
    
    // =================================
    // MARK: 注册
    // =================================
    
    static func register_student() -> String {
        return apiPath("/register/student")
    }
    
    static func register_teacher() -> String {
        return apiPath("/register/teacher")
    }
    
    
    
}
