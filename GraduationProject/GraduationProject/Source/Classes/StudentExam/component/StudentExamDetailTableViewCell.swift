//
//  StudentExamDetailTableViewCell.swift
//  GraduationProject
//
//  Created by Snake on 2018/4/24.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit

class StudentExamDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
