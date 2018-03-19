//
//  SingleItemView.swift
//  renbo
//
//  Created by dev on 2017/12/20.
//  Copyright © 2017年 iAskDoc Technology. All rights reserved.
//

import UIKit


class SingleItemView: YTNibCustomView {

    
    private let titleLabelLeadingConstant: CGFloat = 10
    private let titleLabelLeadingWithoutLeftIcon: CGFloat = 0
    
    private let contentLabelTrailingConstant: CGFloat = 5

    
    @IBOutlet weak var leftIcon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var rightIcon: UIImageView!
    
    @IBOutlet weak var lineView: UIView!
    
    @IBOutlet weak var titleLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentLabelTrailingConstraint: NSLayoutConstraint!
    
    
    
    @IBInspectable
    var isHiddenLeftIcon: Bool = false {
        didSet {
            self.hiddenLeftIconHandler()
        }
    }
    
    @IBInspectable
    var isHiddenRightIcon: Bool = false {
        didSet {
            self.hiddenRightIconHandler()
        }
    }
    
    
    @IBInspectable
    var isHiddenLineView: Bool = false {
        didSet {
            self.hiddenLineViewHandler()
        }
    }
    
    
    @IBInspectable
    var title: String = "" {
        didSet {
            if self.titleLabel != nil {
                self.titleLabel.text = title
            }
        }
    }
    
    @IBInspectable
    var content: String = "" {
        didSet {
            if self.contentLabel != nil {
                self.contentLabel.text = content
            }
        }
    }
    
    @IBInspectable
    var leftIconImage: UIImage! = UIImage(named: "arrow_right") {
        didSet {
            if self.leftIcon != nil {
                self.leftIcon.image = leftIconImage
            }
        }
    }
   
    
    // =================================
    // MARK:
    // =================================
    
    
    override func initSubviews() {
        super.initSubviews()
        //
        self.titleLabel.text = self.title
        self.contentLabel.text = self.content
        self.leftIcon.image = self.leftIconImage
        self.hiddenLeftIconHandler()
        self.hiddenRightIconHandler()
        self.hiddenLineViewHandler()
    }
    
    
    // 隐藏左侧图标
    private func hiddenLeftIconHandler() {
        if self.leftIcon == nil {
            return
        }
        self.leftIcon.isHidden = self.isHiddenLeftIcon
        self.titleLabelLeadingConstraint.constant = self.isHiddenLeftIcon ? (self.titleLabelLeadingWithoutLeftIcon - self.leftIcon.width) : self.titleLabelLeadingConstant
    }
    
    // 隐藏右侧图标
    private func hiddenRightIconHandler() {
        if self.rightIcon == nil {
            return
        }
        self.rightIcon.isHidden = self.isHiddenRightIcon
        self.contentLabelTrailingConstraint.constant = self.isHiddenRightIcon ? (-self.rightIcon.width) : self.contentLabelTrailingConstant
    }

    // 隐藏分割线
    private func hiddenLineViewHandler() {
        if self.lineView == nil {
            return
        }
        self.lineView.isHidden = self.isHiddenLineView
    }
}
