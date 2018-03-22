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
    
    var id: String = ""
    var password: String = ""
    var role: String = ""

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        //
        id <- map["id"]
        password <- map["password"]
    }
    
}

