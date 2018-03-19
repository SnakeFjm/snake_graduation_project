//
//  CustomSegmentView.swift
//  renbo
//
//  Created by Chensh on 2018/3/8.
//  Copyright © 2018年 iAskDoc Technology. All rights reserved.
//

import UIKit


@objc protocol CustomSegmentViewDelegate: NSObjectProtocol {
    
    //
    @objc func numberOfTitlesInSegmentView() -> Int
    
    //
    @objc func titleInSegmentView(atIndex index: Int) -> String
    
    //
    @objc func segmentViewDidSelected(atIndex index: Int)
    
}

class CustomSegmentView: UIView {
    
    @IBInspectable
    var lineWidth: CGFloat = 30 {
        didSet {
            self.updateUnderLineView()
        }
    }
    
    let lineHeight: CGFloat = 3
    
    private var buttonArray: [UIButton] = []
    
    var titleArray: [String] = []
    
    var underLineView: UIView = UIView.init()
    
    var delegate: CustomSegmentViewDelegate!
    
    var currentSelected: Int = 0
    
    var lineViewLeadingConstraint: NSLayoutConstraint!
    
    // ================================
    // MARK:
    // ================================
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //
        self.initSubViews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //
        self.initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initSubViews() {
        self.backgroundColor = .white
        self.initUnderLineView()
    }
    
    // ================================
    // MARK:
    // ================================
    
    private func removeAllButton() {
        for item in self.buttonArray {
            item.removeFromSuperview()
        }
        self.buttonArray.removeAll()
        //
        self.underLineView.isHidden = true
    }
    
    func reloadData() {
        //
        self.removeAllButton()
        //
        self.createButtons()
        //
        self.updateUnderLineView()
    }
    
    
    func createButtons() {
        if self.delegate == nil {
            return
        }
        var count = 0
        if self.delegate.responds(to: #selector(CustomSegmentViewDelegate.numberOfTitlesInSegmentView)) {
            count = self.delegate.numberOfTitlesInSegmentView()
        }
        if count == 0 {
            return
        }
        //
        var lastButton: UIButton!
        for index in 0..<count {
            //
            let button = self.createButton(index: index)
            self.buttonArray.append(button)
            self.addSubview(button)
            //
            if index == 0 {
                button.isSelected = true
                self.currentSelected = 0
            }
            //
            if index == 0 {
                button.autoPinEdge(.left, to: .left, of: self)
            } else {
                button.autoPinEdge(.left, to: .right, of: lastButton)
                button.autoMatch(.width, to: .width, of: lastButton)
            }
            button.autoPinEdge(.top, to: .top, of: self)
            button.autoPinEdge(.bottom, to: .bottom, of: self)
            if index == count - 1 {
                button.autoPinEdge(.right, to: .right, of: self)
            }
            //
            lastButton = button
        }
    }
    
    // 创建按钮
    func createButton(index: Int) -> UIButton {
        let button = UIButton(type: .custom)
        button.tag = index
        button.setTitleColor(UIColor.RGBSameMake(value: 0x99), for: .normal)
        button.setTitleColor(UIColor.RGBSameMake(value: 0x33), for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(buttonDidTouch(_:)), for: .touchUpInside)
        //
        if self.delegate.responds(to: #selector(CustomSegmentViewDelegate.titleInSegmentView(atIndex:))) {
            let title = self.delegate.titleInSegmentView(atIndex: index)
            button.setTitle(title, for: .normal)
            button.setTitle(title, for: .selected)
        }
        return button
    }
    
    
    func initUnderLineView() {
        self.underLineView.backgroundColor = UIColor.RGBMake(r: 0x2D, g: 0xA7, b: 0xE9)
        self.underLineView.xCornerRadius = self.lineHeight / 2
        self.underLineView.cMasksToBounds = true
        self.addSubview(self.underLineView)
        //
        self.underLineView.autoSetDimensions(to: CGSize(width: self.lineWidth, height: self.lineHeight))
        self.underLineView.autoPinEdge(.bottom, to: .bottom, of: self)
        self.lineViewLeadingConstraint = self.underLineView.autoPinEdge(.left, to: .left, of: self)
    }
    
    
    func updateUnderLineView() {
        //
        let count = self.buttonArray.count
        self.underLineView.isHidden = (count == 0)
        if  count == 0 {
            return
        }
        //
        let btnWidth = ScreenWidth / CGFloat(self.buttonArray.count)
        let x = (btnWidth - self.lineWidth) / 2 + CGFloat(self.currentSelected) * btnWidth
        UIView.animate(withDuration: 0.2) {
            self.lineViewLeadingConstraint.constant = x
        }
    }
    
    // ================================
    // MARK:
    // ================================
    
    @objc func buttonDidTouch(_ sender: UIButton) {
        if self.currentSelected == sender.tag {
            return
        }
        //
        for item in self.buttonArray {
            item.isSelected = false
        }
        //
        self.currentSelected = sender.tag
        sender.isSelected = true
        //
        self.updateUnderLineView()
        //
        if self.delegate != nil && self.delegate.responds(to: #selector(CustomSegmentViewDelegate.segmentViewDidSelected(atIndex:))) {
            self.delegate.segmentViewDidSelected(atIndex: self.currentSelected)
        }
    }
    
    
}
