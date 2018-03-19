//
//  FoldTableHeaderView.swift
//  renbo
//
//  Created by dev on 2017/12/21.
//  Copyright © 2017年 iAskDoc Technology. All rights reserved.
//

import UIKit


typealias FoldCompletion = (_ state: Bool) -> ()


// 收缩头部
class FoldTableHeaderView: UITableViewHeaderFooterView {
    
    static let identifier: String = "FoldTableHeaderView"

    @IBOutlet weak var foldIconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    // 是否收缩
    var foldState: Bool = false {
        didSet {
            self.updateFoldIconView()
        }
    }
    
    // 是否需要收缩
    var needFold: Bool = true
    
    var completion: FoldCompletion!
    
    
    // =================================
    // MARK:
    // =================================
    
    
    @IBAction func buttonDidTouch(_ sender: UIButton) {
        //
        if !needFold {
            return
        }
        //
        self.foldState = !self.foldState
        //
        if completion != nil {
            completion(self.foldState)
        }
    }
    
    // 更新
    private func updateFoldIconView() {
        UIView.animate(withDuration: 0.5) {
            self.foldIconView.image = UIImage(named: self.foldState ? "group_triangle_up" : "group_triangle")
        }
    }
    
    
}
