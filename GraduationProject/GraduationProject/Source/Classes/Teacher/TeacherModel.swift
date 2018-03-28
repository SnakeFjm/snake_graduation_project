//
//  TeacherModel.swift
//  GraduationProject
//
//  Created by Snake on 2018/3/28.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper

class TeacherModel: Mappable {
    //
    var id: String = ""
    var name: String = ""
    var college: String = ""
    var teacherCourse: [CourseModel]!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        //
        id <- map["id"]
        name <- map["name"]
        college <- map["college"]
        teacherCourse <- map["teacherCourse"]
    }
}


class CourseModel: Mappable {
    //
    var id: String = ""
    var name: String = ""
    var teacherId: String = ""
    var courseYear: String = ""
    var Number: String = ""
    var Time: String = ""
    var classroom: String = ""
    var weekCount: String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        //
        id <- map["id"]
        name <- map["name"]
        teacherId <- map["teacherId"]
        courseYear <- map["courseYear"]
        Number <- map["Number"]
        Time <- map["Time"]
        classroom <- map["classroom"]
        weekCount <- map["weekCount"]
    }
}










