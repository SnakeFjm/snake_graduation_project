//
//  CustomSearchBar.swift
//  renbo
//
//  Created by Chensh on 2018/3/11.
//  Copyright © 2018年 iAskDoc Technology. All rights reserved.
//

import UIKit

@objc protocol CustomSearchBarDelegate: NSObjectProtocol {
    
    @objc optional func searchBarCancelButtonDidTouch()
    
    @objc optional func searchBarSearchButtonDidTouch()
    
}

class CustomSearchBar: YTNibCustomView, UITextFieldDelegate {
    
    let trailingConstantWithButton: CGFloat = 50
    let trailingConstantWithoutButton: CGFloat = 10

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var textFieldBgViewTrailingConstraint: NSLayoutConstraint!
    
    var delegate: CustomSearchBarDelegate!
    
    private var isEditing: Bool = false
    
    
    var placeholder: String = "搜索" {
        didSet {
            self.setPlaceHolderString()
        }
    }
    
    // ================================
    // MARK:
    // ================================
    
    override func initSubviews() {
        super.initSubviews()
        //
        self.showCancelButton(show: false)
    }
    
    @IBAction func cancelButtonDidTouch(_ sender: Any) {
        //
        self.showCancelButton(show: false)
        //
        self.isEditing = false
        //
        self.textField.text = ""
        //
        self.textField.resignFirstResponder()
    }
    
    
    // ================================
    // MARK:
    // ================================
    
    private func showCancelButton(show: Bool) {
        if self.isEditing && show {
            return
        }
        //
        UIView.animate(withDuration: 0.3) {
            self.textFieldBgViewTrailingConstraint.constant = show ? self.trailingConstantWithButton : self.trailingConstantWithoutButton
            self.cancelButton.isHidden = !show
        }
    }
    
    // ================================
    // MARK:
    // ================================
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            //
            self.textField.resignFirstResponder()
            //
            if self.delegate != nil && self.delegate.responds(to: #selector(CustomSearchBarDelegate.searchBarSearchButtonDidTouch)) {
                self.delegate.searchBarSearchButtonDidTouch!()
            }
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.showCancelButton(show: true)
        self.isEditing = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.isEditing = false
    }
    
    // ================================
    // MARK:
    // ================================
    
    func searchContent() -> String? {
        return self.textField.text
    }
    
    
    // ================================
    // MARK:
    // ================================
    
    func setPlaceHolderString() {
        if self.textField == nil {
            return
        }
        self.textField.placeholder = self.placeholder
    }

}
