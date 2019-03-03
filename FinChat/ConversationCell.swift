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
    
    @IBOutlet weak var messageLabel: UILabel!
    
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
        /*
        NSLayoutConstraint(item: messageLabel, attribute: .leading, relatedBy: .equal, toItem: superview, attribute: .leadingMargin, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: messageLabel, attribute: .trailing, relatedBy: .equal, toItem: superview, attribute: .trailingMargin, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: messageLabel, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .topMargin, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: messageLabel, attribute: .bottom, relatedBy: .equal, toItem: superview, attribute: .bottomMargin, multiplier: 1.0, constant: 0.0).isActive = true
        */
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

