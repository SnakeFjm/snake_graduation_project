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
        var result = BaseSettingManager.shared.hostName() + "/api/v\(version)"
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
    // MARK: 用户接口集
    // =================================
    
    // 退出登录
    static func detect_logout() -> String {
        return apiPath("/user/logout")
    }
    
    // 微信登录: 通过 code 获取用户登录信息
    static func detect_wx(code: String) -> String {
        return apiPath("/user/wx/\(code)")
    }
    
    // 手机登录: 手机号是否已注册，同时发送验证码
    static func detect_mobileLogin(mobile: String) -> String {
        return apiPath("/user/reg-status/\(mobile)")
    }
    
    // 微信登录绑定手机获取验证码
    static func detect_vcodeBindMobile() -> String {
        return apiPath("/user/ver/code")
    }
    
    // 校验验证码
    static func detect_vcodeCheck() -> String {
        return apiPath("/user/vcode")
    }
    
    // 填写用户名完成注册
    static func detect_reg() -> String {
        return apiPath("/user/reg")
    }
    
    // 获取个人资料
    static func detect_user() -> String {
        return apiPath("/user")
    }
    
    // 修改用户名信息
    static func detect_info_wx() -> String {
        return apiPath("/user/info/wx")
    }
    
    // 绑定手机号
    static func detect_accountMobile() -> String {
        return apiPath("/user/account/mobile")
    }
    
    // 绑定微信
    static func detect_accountWx() -> String {
        return apiPath("/user/account/wx")
    }
    
    // 填写基本信息/重新测评
    static func detect_basicInfo() -> String {
        return apiPath("/user/basic-info")
    }
    
    // 上传头像
    static func detect_icon() -> String {
        return apiPath("/user/icon")
    }
    
    // =================================
    // MARK: 热量管理接口集
    // =================================
    
    // GET /api/v1/cal 获取用户某天热量管理列表数据
    // POST /api/v1/cal 添加单餐热量数据
    static func cal() -> String {
        return apiPath("/cal")
    }
    
    // GET /api/v1/cal/meal 获取热量管理详情数据
    static func cal_meal() -> String {
        return apiPath("/cal/meal")
    }
    
    // DELETE /api/v1/cal/{id} 删除单餐热量数据 修改单餐热量数据
    static func cal(id: Int64) -> String {
        return apiPath("/cal/\(id)")
    }
    
    // GET /api/v1/cal/view/line 分页获取某段时间每天摄入热量(折线图)
    static func cal_view_line() -> String {
        return apiPath("/cal/view/line")
    }
    
    // GET /api/v1/cal/view/tab 分页获取列表(x宫格图)
    static func cal_view_tab() -> String {
        return apiPath("/cal/view/tab")
    }
    
    // GET /api/v1/cal/meal/{uuid} 获取热量管理详情-食物营养数据
    static func cal_meal(uuid: String) -> String {
        return apiPath("/cal/meal/\(uuid)")
    }
    
    // =================================
    // MARK: 食物检测接口
    // =================================
    
    //食物检测接口
    static func detect_img() -> String {
        return apiPath("/detect/img/detect")
    }
    
    // GET /api/v1/detect/record 分页获取拍食记录
    static func detect_record() -> String {
        return apiPath("/detect/record")
    }
    
    // 删除拍食记录
    static func detect_recordDelete(detectId: Int) -> String {
        return apiPath("/detect/\(detectId)")
    }
    
    // =================================
    // MARK: food-controller : 菜谱/营养数据接口集
    // =================================
    
    //检测后获取食物营养数据
    static func detect_food() -> String {
        return apiPath("/food")
    }
    
    //通过uuid获取食物营养数据
    static func detect_foodByuuid(uuid: String) -> String {
        return apiPath("/food/\(uuid)")
    }
    
    // POST /api/v1/food/name 没有想要的结果：提交
    static func detect_noFoodResult() -> String {
        return apiPath("/food/name")
    }
    
    //搜索接口
    static func detect_search() -> String {
        return apiPath("/food/search")
    }
    
    // =================================
    // MARK: 会员激活接口集
    // =================================
    
    //激活会员
    static func detect_vip() -> String {
        return apiPath("/vip")
    }
    
    // =================================
    // MARK: app初始化数据接口集
    // =================================
    
    // 下发参数接口
    static func app_init() -> String {
        return apiPath("/init")
    }
    
    // =================================
    // MARK: 文件接口
    // =================================
    
    // 文件上传
    static func detect_base_File() -> String {
        return apiPath("/base/file")
    }
    
    // ================================
    // MARK: user-op-log-controller : 用户行为日志管理接口集
    // ================================
    
    // POST /api/v1/log
    // 上传单条用户日志
    static func log() -> String {
        return apiPath("/log")
    }
    
    // POST /api/v1/log/list
    // 批量上传用户日志
    static func log_list() -> String {
        return apiPath("/log/list")
    }
}
