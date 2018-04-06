//
//  CourseYearViewControllerViewController.swift
//  GraduationProject
//
//  Created by Snake on 2018/4/1.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit

class CourseYearViewControllerViewController: YTPickerViewController {

    // 2018-3 / 9
    var courseYearArray: [Int] = []
    var courseMonthArray: [Int] = []
    
    private var alreadySelectedTall: Int = 0
    
    // ================================
    // MARK:
    // ================================
    
    convenience init(tall: Int) {
        self.init()
        self.alreadySelectedTall = tall
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.initDataArray()
        //
//        for index in 0..<self.tallArray.count {
//            let tall = self.tallArray[index]
//            if tall == self.alreadySelectedTall {
//                self.xpicker.pickerView.selectRow(index, inComponent: 0, animated: false)
//                break
//            }
//        }
        //
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy"
        let date = Date.init()
        let dateString = dateFormatter.string(from: date)
        let dateInt = Int(dateString)!
        //
        self.xpicker.pickerView.selectRow(dateInt - 2000, inComponent: 0, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ================================
    // MARK:
    // ================================
    
    func initDataArray() {
        //
        self.courseYearArray = []
        for courseYear in 2000...2050 {
            self.courseYearArray.append(courseYear)
        }
        //
        self.courseMonthArray = [3, 9]
    }
    
    // ================================
    // MARK:
    // ================================
    
    override func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    override func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return self.courseYearArray.count
        } else {
            return 2
        }
    }
    
    override func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            let courseYear = self.courseYearArray[row]
            return "\(courseYear)"
        } else {
            let courseMonth = self.courseMonthArray[row]
            return "\(courseMonth)"
        }
    }
    
    // ================================
    // MARK:
    // ================================
    
    override func confirmButtonDidTouch(_ sender: Any) {
        super.confirmButtonDidTouch(sender)
        //
        if self.pickerDelegate != nil && self.pickerDelegate.responds(to: #selector(YTPickerViewControllerDelegate.courseYearPickerViewControllerConfirmButtonDidTouch(courseYear:courseMonth:))) {
            //
            let row0 = self.xpicker.pickerView.selectedRow(inComponent: 0)
            let courseYear = self.courseYearArray[row0]
            //
            let row1 = self.xpicker.pickerView.selectedRow(inComponent: 1)
            let courseMonth = self.courseMonthArray[row1]
            //
            self.pickerDelegate.courseYearPickerViewControllerConfirmButtonDidTouch!(courseYear: "\(courseYear)", courseMonth: "\(courseMonth)")
        }
    }

}
