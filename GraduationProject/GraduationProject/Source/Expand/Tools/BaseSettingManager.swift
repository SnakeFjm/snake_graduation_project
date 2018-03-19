//
//  BaseSettings.swift
//  meimabang
//
//  Created by dev on 2016/11/18.
//  Copyright © 2016年 广州雅特网络科技. All rights reserved.
//

import UIKit


enum EnvironmentType {
    case DEV // 开发环境
    case TEST // 测试环境
    case DIS // 线上环境
}

enum ChannelType {
    case Inhouse // 企业版
    case AppStore // AppStore版本
}


class BaseSettingManager: NSObject {
    
    static let _instance: BaseSettingManager = BaseSettingManager()
    static var shared: BaseSettingManager {
        return _instance
    }

    var infoDict: Dictionary<String, Any>? = nil
    
    
    
    // ============================
    // 这个值定义了 环境
    // ============================
    var type: EnvironmentType = .DEV
    
    
    
    
    // ============================
    // 这个值定义了 渠道
    // ============================
    var channel: ChannelType = .Inhouse
    
    
    //
    override init() {
        super.init()
        
        // 获取info信息
        infoDict = Bundle.main.infoDictionary!
        let bundleId: String = infoDict!["CFBundleIdentifier"] as! String
        
        // 根据包名来判断渠道
        if (bundleId == "com.yate.inhouse.renbo") {
            channel = .Inhouse
        } else {
            channel = .AppStore
        }
        
        // 根据宏定义来更改环境
        #if COMPILE_ENVIRONMENT_FLAG_TEST
            type = .TEST
        #elseif COMPILE_ENVIRONMENT_FLAG_DIS
            type = .DIS
        #endif
        
    }

    
    
    // ============================
    // 这个值定义了 hostname
    // ============================
    
  
    
    
    // 返回渠道名 
    func channelString() -> String {
        switch channel {
        case .Inhouse:
            return "inhouse"
        default:
            return "AppStore"
        }
    }
    
    // 返回运行环境
    func environmentTypeString() -> String {
        switch type {
        case .DEV:
            return "开发"
        case .TEST:
            return "测试"
        default:
            return "线上"
        }
    }
    
    // 返回 version
    func bundleVersion() -> String {
        return infoDict!["CFBundleVersion"] as! String
    }
    
    // 返回 Bundle Short Version String
    func shortVersionString() -> String {
        return infoDict!["CFBundleShortVersionString"] as! String
    }
    
    
    // =================================
    // MARK:
    // =================================
    
    func hostName() -> String {
        switch type {
        case .DEV:
            return "http://dev.api.renbo.dingdingyisheng.mobi"
        case .TEST:
            return "http://jishiqi.dingdingyisheng.mobi"
        default:
            return "http://jishiqi.dingdingyisheng.mobi"
        }
    }
    
    //
    func WXAppID() -> String {
        return ""
    }
    
    // 返回Bugly的AppID
    func buglyAppID() -> String {
        return "c340a9a65b"
    }
    

    // 融云AppId
    func RongCloudAPPKey() -> String {
        switch type {
        case .DEV:
            return "pvxdm17jpi4jr"
        case .TEST:
            return "pvxdm17jpi4jr"
        case .DIS:
            return "pvxdm17jpi4jr"
        }
    }
    
    
}
