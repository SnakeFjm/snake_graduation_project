//
//  StudentSignInDetailTableViewCell.swift
//  GraduationProject
//
//  Created by Snake on 2018/3/28.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit
import SwiftyJSON

class StudentSignInDetailTableViewCell: BaseTableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var signInSituationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func updateCellUI(result: JSON) {
        
    }
    
}
