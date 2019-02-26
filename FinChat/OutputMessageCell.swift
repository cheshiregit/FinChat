//
//  OutputMessageCell.swift
//  FinChat
//
//  Created by Roman Nordshtrem on 26/02/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

import UIKit

class OutputMessageCell: UITableViewCell {

    @IBOutlet weak var outputMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        outputMessageLabel.text = "Other text"
//        outputMessageLabel.backgroundColor = UIColor.blue.withAlphaComponent(0.2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
