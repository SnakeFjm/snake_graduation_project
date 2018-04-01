//
//  TimePickerViewController.swift
//  GraduationProject
//
//  Created by Snake on 2018/4/1.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit

class TimePickerViewController: YTPickerViewController {

    var weekArray: [String] = []
    var startArray: [Int] = []
    var endArray: [Int] = []
    
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
//        //
//        for index in 0..<self.tallArray.count {
//            let tall = self.tallArray[index]
//            if tall == self.alreadySelectedTall {
//                self.xpicker.pickerView.selectRow(index, inComponent: 0, animated: false)
//                break
//            }
//        }
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
        self.weekArray = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        //
        self.startArray = []
        for start in 1...20 {
            self.startArray.append(start)
        }
        //
        self.endArray = []
        for end in 1...20 {
            self.endArray.append(end)
        }
    }
    
    // ================================
    // MARK:
    // ================================
    
    override func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    override func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return self.weekArray.count
        } else if component == 1 {
            return self.startArray.count
        } else {
            return self.endArray.count
        }
    }
    
    override func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            let item = self.weekArray[row]
            return "\(item)"
        } else if component == 1 {
            let item = self.startArray[row]
            return "\(item)"
        } else {
            let item = self.endArray[row]
            return "\(item)"
        }
    }
    
    // ================================
    // MARK:
    // ================================
    
    override func confirmButtonDidTouch(_ sender: Any) {
        super.confirmButtonDidTouch(sender)
        //
        if self.pickerDelegate != nil && self.pickerDelegate.responds(to: #selector(YTPickerViewControllerDelegate.timePickerViewControllerConfirmButtonDidTouch(week:start:end:))) {
            //
            let row0 = self.xpicker.pickerView.selectedRow(inComponent: 0)
            let week = self.weekArray[row0]
            //
            let row1 = self.xpicker.pickerView.selectedRow(inComponent: 1)
            let start = self.startArray[row1]
            //
            let row2 = self.xpicker.pickerView.selectedRow(inComponent: 2)
            let end = self.endArray[row2]
            self.pickerDelegate.timePickerViewControllerConfirmButtonDidTouch!(week: week, start: "\(start)", end: "\(end)")
        }
    }


}
