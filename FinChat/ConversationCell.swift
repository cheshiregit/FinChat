//
//  ConversationCell.swift
//  FinChat
//
//  Created by Roman Nordshtrem on 26/02/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

import UIKit

protocol MessageCellConfiguratioin: class {
    var textMessage: String? { get set }
}

class ConversationCell: UITableViewCell, MessageCellConfiguratioin {
    

    @IBOutlet var bubbleImageView: UIImageView!
    @IBOutlet var messageLabel: UILabel!
    
    var textMessage: String? {
        get {
            return messageLabel.text!
        }
        set (newVal) {
            messageLabel.text = newVal
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

