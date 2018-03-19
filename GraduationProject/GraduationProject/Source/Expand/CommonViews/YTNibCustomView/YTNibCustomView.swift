//
//  YTNibCustomView.swift
//  sanshi
//
//  Created by dev on 2017/5/18.
//  Copyright © 2017年 Chensh. All rights reserved.
//

import UIKit


//@IBDesignable 此类使得xib有从代码初始化的能力
class YTNibCustomView: UIView {
    
    var contentView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initSubviews() {
        //
        contentView = loadViewFromNib()
        //
        addSubview(contentView)
        //
        contentView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    func loadViewFromNib() -> UIView {
        let className = type(of: self)
        let bundle = Bundle(for: className)
        let name = NSStringFromClass(className).components(separatedBy: ".").last
        // 检测nib文件是否存在
        let path: String? = Bundle.main.path(forResource: name, ofType: "nib")
        if path == nil {
            return UIView.init()
        }
        // 
        let nib = UINib(nibName: name!, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    
    

}
