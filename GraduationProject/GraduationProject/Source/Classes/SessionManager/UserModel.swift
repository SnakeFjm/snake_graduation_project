//
//  UserModel.swift
//  FoodDetect
//
//  Created by dev on 2017/11/30.
//  Copyright © 2017年 iAskDoc Technology. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import ObjectMapper



class UserModel: Mappable {
    
    
    var icon: String = ""
    var name: String = ""
    var token: String = ""
    var uuid: String = ""
    // 绑定状态
    var status: Int = 0
    // 每日推荐热量数据
    var caloriesAdvice: Int = 0
    var unit: String = ""
    //
    var basecInfoStatus: Bool = false
    var vip: Bool = false
    //
    var regTime: String = ""

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        icon <- map["icon"]
        name <- map["name"]
        token <- map["token"]
        uuid <- map["uuid"]
        //
        basecInfoStatus <- map["basicInfoStatus"]
        caloriesAdvice <- map["caloriesAdvice"]
        unit <- map["unit"]
        //
        status <- map["status"]
        vip <- map["vip"]
        //
        regTime <- map["regTime"]
        
    }
    
}

