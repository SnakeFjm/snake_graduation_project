//
//  AddTeacherCourseViewController.swift
//  GraduationProject
//
//  Created by Snake on 2018/3/23.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class InfoModel: NSObject {
    
    // 课程名
    var name = ""
    
    // 上课地点
    var classroom = ""
    
    // 上课时间
    var time = ""
    
    // 学年
    var course_year = ""
    
    // 学生数
    var number = ""
    
    // 周数
    var week_count = ""
    
    private var formatter: DateFormatter = DateFormatter.init()
    
    // ================================
    // MARK:
    // ================================
    
    override init() {
        formatter.dateFormat = "yyyy-MM-dd"
    }
    
    // 课程名
    func nameString() -> String {
        if self.name == "" {
            return "点击输入课程名"
        }
        return self.name
    }
    
    // 上课地点
    func classroomString() -> String {
        if self.classroom == "" {
            return "点击输入上课地点"
        }
        return self.classroom
    }
    
    // 上课时间
    func timeString() -> String {
        if self.time == "" {
            return "点击输入上课时间"
        }
        return "\(self.time)"
    }
    
    // 学年
    func courseYearString() -> String {
        if self.course_year == "" {
            return "点击输入学年"
        }
        return "\(self.course_year)"
    }
    
    // 学生数
    func numberString() -> String {
        if self.number == "" {
            return "点击输入学生数"
        }
        return "\(self.number)"
    }
    
    // 周数
    func weekCountString() -> String {
        if self.week_count == "" {
            return "点击输入周数"
        }
        return "\(self.week_count)"
    }
    
    func checkIfEmpty() -> Bool {
        if self.name == "" || self.classroom == "" || self.time == "" || self.course_year == "" || self.number == "" || self.week_count == "" {
            return true
        }
        return false
    }
    
}

class AddTeacherCourseViewController: RefreshTableViewController, YTPickerViewControllerDelegate {

    @IBOutlet var headerView: UIView!
    @IBOutlet var footerView: UIView!
    
    // 信息模型
    var infoModel: InfoModel = InfoModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.title = "添加班级"
        //
        self.dataArray = ["课程名", "上课地点", "上课时间", "学年", "学生数", "周数"]
        //
        self.registerCellNib(nibName: "SingleTableViewCell")
        self.tableView.tableHeaderView = self.headerView
        self.tableView.tableFooterView = self.footerView
//        self.tableView.separatorStyle = .none

        self.reloadTableViewData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // =================================
    // MARK:
    // =================================
    
    // =================================
    // MARK:
    // =================================
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SingleTableViewCell", for: indexPath) as! SingleTableViewCell
        //
        cell.titleLabel.textColor = UIColor.RGBSameMake(value: 51)
        cell.titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        cell.contentLabel.textColor = UIColor.RGBSameMake(value: 153)
        cell.contentLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        //
        cell.titleLabel.text = self.dataArray[indexPath.row].stringValue
        cell.contentLabel.text = self.contentOfCell(index: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        //
        var pickerVC: YTPickerViewController!
        
        switch indexPath.row {
        case 0: // 课程名
            self.updateClassName()
        case 1: // 上课地点
            self.updateClassroom()
        case 2: // 上课时间
            pickerVC = TimePickerViewController.init()
            pickerVC.pickerDelegate = self
            pickerVC.showWith(animated: true, completion: nil)
        case 3: // 学年
            pickerVC = CourseYearViewControllerViewController.init()
            pickerVC.pickerDelegate = self
            pickerVC.showWith(animated: true, completion: nil)
        case 4: // 学生数
            self.updateNumber()
        case 5: // 周数
            self.updateWeekCount()
        default:
            break
        }
    }
    
    // =================================
    // MARK:
    // =================================
    
    // 返回详细内容
    private func contentOfCell(index: Int) -> String {
        // ["课程名", "上课地点", "上课时间", "学年", "学生数", "周数"]
        switch index {
        case 0: // 课程名
            return self.infoModel.nameString()
        case 1: // 上课地点
            return self.infoModel.classroomString()
        case 2: // 上课时间
            return self.infoModel.timeString()
        case 3: // 学年
            return self.infoModel.courseYearString()
        case 4: // 学生数
            return self.infoModel.numberString()
        case 5: // 周数
            return self.infoModel.weekCountString()
        default:
            return ""
        }
    }
    
    func updateClassName() {
        //
        let editor: TextFieldEditorViewController = TextFieldEditorViewController.init(aContent: "", aPlaceholder: "请输入课程名", aTitle: "课程名") {
            [weak self] (content) in
            if content != nil {
                self?.infoModel.name = content!
            }
            self?.reloadTableViewData()
        }
        self.push(editor)
    }
    
    func updateClassroom() {
        //
        let editor: TextFieldEditorViewController = TextFieldEditorViewController.init(aContent: "", aPlaceholder: "请输入上课地点", aTitle: "上课地点") {
            [weak self] (content) in
            if content != nil {
                self?.infoModel.classroom = content!
            }
            self?.reloadTableViewData()
        }
        self.push(editor)
    }
    
    func updateNumber() {
        //
        let editor: TextFieldEditorViewController = TextFieldEditorViewController.init(aContent: "", aPlaceholder: "请输入学生数", aTitle: "学生数") {
            [weak self] (content) in
            if content != nil {
                self?.infoModel.number = content!
            }
            self?.reloadTableViewData()
        }
        self.push(editor)
    }
    
    func updateWeekCount() {
        //
        let editor: TextFieldEditorViewController = TextFieldEditorViewController.init(aContent: "", aPlaceholder: "请输入周数", aTitle: "周数") {
            [weak self] (content) in
            if content != nil {
                self?.infoModel.week_count = content!
            }
            self?.reloadTableViewData()
        }
        self.push(editor)
    }
    
    // =================================
    // MARK:
    // =================================
    
    func timePickerViewControllerConfirmButtonDidTouch(week: String, start: String, end: String) {
        let time = week + "-" + start + "-" + end
        self.infoModel.time = time
        self.reloadTableViewData()
    }
    
    func courseYearPickerViewControllerConfirmButtonDidTouch(courseYear: String, courseMonth: String) {
        let course_year = courseYear + "-" + courseMonth
        self.infoModel.course_year = course_year
        self.reloadTableViewData()
    }
    
    // =================================
    // MARK:
    // =================================
    
    @IBAction func addClassButtonDidTouch(_ sender: Any) {
        //
        if self.infoModel.checkIfEmpty() {
            showAlertController(title: "提示", message: "内容不能为空")
            return
        }
        //
        let apiName = URLManager.teacher_course_add()
        let teacherID = UserManager.shared.userModel.id
        let parameter: Parameters = ["name": self.infoModel.name,
                                    "teacherID": teacherID,
                                    "classroom": self.infoModel.classroom,
                                    "time": self.infoModel.time,
                                    "course_year": self.infoModel.course_year,
                                    "number": self.infoModel.number,
                                    "week_count": self.infoModel.week_count]
        //
        HttpManager.shared.postRequest(apiName, parameters: parameter, encoding: JSONEncoding.default).responseJSON { [weak self] (response) in
            //
            if let _ = HttpManager.parseDataResponse(response) {
                //
                showSuccessTips("创建成功")
            } else {
                showErrorTips("创建失败")
            }
        }
    }
    
}
