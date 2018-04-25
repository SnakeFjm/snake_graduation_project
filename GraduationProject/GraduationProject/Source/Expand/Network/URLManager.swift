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
    
    // 学生登录 "/login/student"  post
    static func login_student() -> String {
        return apiPath("/login/student")
    }
    
    // 教师登录 "/login/teacher"  post
    static func login_teacher() -> String {
        return apiPath("/login/teacher")
    }
    
    // =================================
    // MARK: 注册 post
    // =================================
    
    // 学生注册 "/register/student"   post
    static func register_student() -> String {
        return apiPath("/register/student")
    }
    
    // 老师注册 "/register/teacher"  post
    static func register_teacher() -> String {
        return apiPath("/register/teacher")
    }
    
    // =================================
    // MARK: 学生
    // =================================
    
    // 通过学生ID查看学生已加入的课程名清单  "/student/course/easy-info"  post
    static func student_course_easy_info() -> String {
        return apiPath("/student/course/easy-info")
    }
    
    // 通过课程id查看课程的详细信息   "/student/course/detail-info"   post
    static func student_course_detail_info() -> String {
        return apiPath("/student/course/detail-info")
    }
    
    // 学生签到  “/student/sign”  put
    static func student_sign() -> String {
        return apiPath("/student/sign")
    }
    
    // 根据课程id获取该门课已开放的试题   "/student/test"  post
    static func student_test() -> String {
        return apiPath("/student/test")
    }
    
    // 学生答题完成后记录成绩  "/student/record"   put
    static func student_record() -> String {
        return apiPath("/student/record")
    }
    
    // 学生加入某门课程  "/student/course/add"   post
    static func student_course_add() -> String {
        return apiPath("/student/course/add")
    }
    
    // =================================
    // MARK: 教师
    // =================================
    
    // 老师创建一门课程  "/teacher/course/add"   post
    static func teacher_course_add() -> String {
        return apiPath("/teacher/course/add")
    }
    
    // 老师查看自己已创建的课程  "/teacher/course"   post
    static func teacher_course() -> String {
        return apiPath("/teacher/course")
    }
    
    static func teacher_call_name() -> String {
        return apiPath("/teacher/call-name")
    }
    
    // 老师查看某门课程的学生已签到次数   "/teacher/call_name-count"   post
    static func teacher_call_name_count() -> String {
        return apiPath("/teacher/call_name-count")
    }
    
    // 老师查看某门课某位学生的详细签到情况  "/teacher/call_name-detail"  post
    static func teacher_call_name_detail() -> String {
        return apiPath("/teacher/call_name-detail")
    }
    
    // 从某门课程中删除某个学生,并且删除该学生的该门课的点名情况 "/teacher/delete-student"  delete
    static func teacher_delete_student() -> String {
        return apiPath("/teacher/delete-student")
    }
    
    // 老师查看某门课程的所有套题清单  /teacher/test-all  post
    static func teacher_test_all() -> String {
        return apiPath("/teacher/test-all")
    }
    
    // 查看某门课程的某套题的详细内容  "/teacher/test-all-detail"  post
    static func teacher_test_all_detail() -> String {
        return apiPath("/teacher/test-all-detail")
    }
    
    // 老师根据课程ID和课程周数开放/关毕某门课程的某套试题（此接口需修改） "/teacher/test/open-close"   put
    static func teacher_test_open_close() -> String {
        return apiPath("/teacher/test/open-close")
    }
    
    // =================================
    // MARK: 课程
    // =================================
    
    // 选课中心获取所有课程清单  "/course"  post
    static func course() -> String {
        return apiPath("/course")
    }
    
    // =================================
    // MARK: 详细个人信息
    // =================================
    
}
