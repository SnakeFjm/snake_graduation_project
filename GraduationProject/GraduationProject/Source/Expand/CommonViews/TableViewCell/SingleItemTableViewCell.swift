//
//  SingleItemTableViewCell.swift
//  FoodDetect
//
//  Created by dev on 2017/12/5.
//  Copyright © 2017年 iAskDoc Technology. All rights reserved.
//

import UIKit

class SingleItemTableViewCell: BaseTableViewCell {

    static let identifier: String = "SingleItemTableViewCell"
    
    @IBOutlet weak var item: SingleItemView!
    
    @IBOutlet weak var itemViewHeightConstraint: NSLayoutConstraint!
    
    // =================================
    // MARK:
    // =================================
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
