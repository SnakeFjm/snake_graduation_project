//
//  CommonTableViewCell.swift
//  FoodDetect
//
//  Created by Snake on 2017/12/15.
//  Copyright © 2017年 iAskDoc Technology. All rights reserved.
//

import UIKit

class CommonTableViewCell: BaseTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
