//
//  YTPickerViewController.swift
//  FoodDetect
//
//  Created by dev on 2017/12/18.
//  Copyright © 2017年 iAskDoc Technology. All rights reserved.
//

import UIKit
import QMUIKit


@objc protocol YTPickerViewControllerDelegate: NSObjectProtocol {
    
    @objc optional func pickerViewControllerConfirmButtonDidTouch(date: Date)
    
    @objc optional func pickerViewControllerConfirmButtonDidTouch(bankName: String, bankId: Int)
    
}


class YTPickerViewController: QMUIModalPresentationViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    var xpicker: XPickerView!
    var PickerViewHeight: CGFloat = 250
    var pickerDelegate: YTPickerViewControllerDelegate!
    
    
    // =================================
    // MARK:
    // =================================


    override func viewDidLoad() {
        super.viewDidLoad()

        //
        self.initContentView()
        self.addLayoutBlock()
        self.addAnimations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // =================================
    // MARK:
    // =================================


    func initContentView() {
        //
        self.xpicker = XPickerView.init(frame: CGRect(x: 0, y: ScreenHeight - PickerViewHeight, width: ScreenWidth, height: PickerViewHeight))
        self.xpicker.pickerView.delegate = self
        self.xpicker.pickerView.dataSource = self
        self.xpicker.cancelButton.addTarget(self, action: #selector(cancelButtonDidTouch(_:)), for: .touchUpInside)
        self.xpicker.confirmButton.addTarget(self, action: #selector(confirmButtonDidTouch(_:)), for: .touchUpInside)
        //
        self.contentView = self.xpicker
    }

    func addLayoutBlock() {
        self.layoutBlock = {
            [weak self] (containerBounds, keyboardHeight, contentViewDefaultFrame) in
            self?.contentView.frame = CGRectSetXY((self?.contentView.frame)!, CGFloatGetCenter(containerBounds.width, (self?.contentView.width)!), containerBounds.height - (self?.contentView.height)!)
        }
    }

    func addAnimations() {

        //
        self.showingAnimation = {
            [weak self] (dimmingView, containerBounds, keyboardHeight, contentViewFrame, completion) in
            self?.contentView.y = containerBounds.height
            dimmingView?.alpha = 0
            UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions(rawValue: UIViewAnimationOptions.RawValue(QMUIViewAnimationOptionsCurveOut)), animations: {
                dimmingView?.alpha = 1
                self?.contentView.frame = contentViewFrame
            }, completion: { (finished) in
                if completion != nil {
                    completion!(finished)
                }
            })
        }

        //
        self.hidingAnimation = {
            [weak self] (dimmingView, containerBounds, keyboardHeight, completion) in
            UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions(rawValue: UIViewAnimationOptions.RawValue(QMUIViewAnimationOptionsCurveOut)), animations: {

                dimmingView?.alpha = 0
                self?.contentView.y = containerBounds.height

            }, completion: { (finished) in
                if completion != nil {
                    completion!(finished)
                }
            })
        }
    }


    // =================================
    // MARK:
    // =================================

    @objc func cancelButtonDidTouch(_ sender: Any) {
        self.hideWith(animated: true, completion: nil)
    }

    @objc func confirmButtonDidTouch(_ sender: Any) {
        //
        self.hideWith(animated: true, completion: nil)
    }
    
    
    // =================================
    // MARK:
    // =================================
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ""
    }
    

}
