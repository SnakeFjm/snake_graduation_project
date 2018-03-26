//
//  StudentCourseTableViewCell.swift
//  GraduationProject
//
//  Created by Snake on 2018/3/26.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit
import SwiftyJSON

class StudentCourseTableViewCell: BaseTableViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var courseYearLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var classroomLabel: UILabel!
    @IBOutlet weak var teacherNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func updateCellUI(result: JSON) {
        
    }
}
