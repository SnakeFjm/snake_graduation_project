//
//  TextFieldEditorViewController.swift
//  renbo
//
//  Created by dev on 2017/12/25.
//  Copyright © 2017年 iAskDoc Technology. All rights reserved.
//

import UIKit


typealias TextFieldEditorCompletion = (_ content: String?) -> ()


class TextFieldEditorViewController: BaseViewController {

    
    @IBOutlet weak var textField: UITextField!
    
    var titleString: String = ""
    
    var placeholderString: String = ""
    
    var contentString: String = ""
    
    var minLength: Int = 1 // 最小长度, 为0时，表示可以为空
    
    var maxLength: Int = 20 // 最大长度
    
    var completion: TextFieldEditorCompletion!
    
    // =================================
    // MARK:
    // =================================
    
    convenience init(aContent: String = "", aPlaceholder: String = "", aTitle: String = "设置", aMinLength: Int = 1, aMaxLength: Int = 20, aCompletion: TextFieldEditorCompletion? = nil) {
        self.init()
        //
        self.contentString = aContent
        self.placeholderString = aPlaceholder
        self.titleString = aTitle
        self.minLength = aMinLength
        self.maxLength = aMaxLength
        self.completion = aCompletion
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.navBarAddRightBarButton(title: "完成")
        self.rightBarButton.isEnabled = false
        
        //
        self.title = self.titleString
        //
        self.textField.placeholder = self.placeholderString
        self.textField.text = self.contentString
        self.textField.addTarget(self, action: #selector(textFieldTextDidChange(_:)), for: .editingChanged)
        //
        self.textField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // =================================
    // MARK: UITextField Delegate
    // =================================
    
    @objc func textFieldTextDidChange(_ sender: Any) {
        self.rightBarButton.isEnabled = !isStringEmpty(self.textField.text)
    }
    
    
    // =================================
    // MARK:
    // =================================
    
    override func navBarRightBarButtonDidTouch(_ sender: Any) {
        //
        self.view.endEditing(true)
        
        //
        guard let content: String = self.textField.text else {
            // 如果最小长度为0，则可以允许为空
            if self.minLength == 0, self.completion != nil {
                self.completion(nil)
            } else {
                showAlertController(title: "内容不能为空", message: "")
            }
            return
        }
        
        // 检测长度
        if !self.checkLengthValid(content: content) {
            return
        }
        
        //
        if self.completion != nil {
            self.completion(content)
        }
        
        // 返回
        self.back()
    }
    
    
    // 检测长度
    func checkLengthValid(content: String) -> Bool {
        let count = content.characters.count
        if count < self.minLength || count > self.maxLength {
            showAlertController(title: "内容长度为\(self.minLength)-\(self.maxLength)个字符", message: "")
            return false
        }
        return true
    }

    
}
