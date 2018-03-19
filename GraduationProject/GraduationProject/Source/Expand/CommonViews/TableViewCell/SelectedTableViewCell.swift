//
//  SelectedTableViewCell.swift
//  renbo
//
//  Created by dev on 2017/12/21.
//  Copyright © 2017年 iAskDoc Technology. All rights reserved.
//

import UIKit

class SelectedTableViewCell: BaseTableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var tickIcon: UIImageView!
    
    
    var isItemSelected: Bool = false {
        didSet {
            if tickIcon != nil {
                tickIcon.isHidden = !isItemSelected
            }
        }
    }
    
    // =================================
    // MARK:
    // =================================
    

    override func awakeFromNib() {
        super.awakeFromNib()
        //
        self.tickIcon.isHidden = !self.isItemSelected
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
