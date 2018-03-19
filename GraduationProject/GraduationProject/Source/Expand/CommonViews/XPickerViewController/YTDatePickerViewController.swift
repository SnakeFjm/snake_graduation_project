//
//  YTDatePickerViewController.swift
//  renbo
//
//  Created by Chensh on 2018/3/8.
//  Copyright © 2018年 iAskDoc Technology. All rights reserved.
//

import UIKit

class YTDatePickerViewController: YTPickerViewController {

    var xDatePicker: XDatePickerView!
    
    
    // ================================
    // MARK:
    // ================================

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // =================================
    // MARK:
    // =================================
    
    
    override func initContentView() {
        //
        self.xDatePicker = XDatePickerView.init(frame: CGRect(x: 0, y: ScreenHeight - PickerViewHeight, width: ScreenWidth, height: PickerViewHeight))
        self.xDatePicker.cancelButton.addTarget(self, action: #selector(cancelButtonDidTouch(_:)), for: .touchUpInside)
        self.xDatePicker.confirmButton.addTarget(self, action: #selector(confirmButtonDidTouch(_:)), for: .touchUpInside)
        //
        self.contentView = self.xDatePicker
        
    }
    
    override func confirmButtonDidTouch(_ sender: Any) {
        super.confirmButtonDidTouch(sender)
        //
        if self.pickerDelegate != nil && self.pickerDelegate.responds(to: #selector(YTPickerViewControllerDelegate.pickerViewControllerConfirmButtonDidTouch(date:))) {
            self.pickerDelegate.pickerViewControllerConfirmButtonDidTouch!(date: self.xDatePicker.pickerView.date)
        }
    }
    
    
}
