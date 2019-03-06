//
//  CustomTableViewCell.swift
//  FinChat
//
//  Created by Roman Nordshtrem on 25/02/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

import UIKit

protocol ConversationCellConfiguratioin: class {
    var name: String? { get set }
    var message: String? { get set }
    var date: Date? { get set }
    var online: Bool { get set }
    var hasUreadMessages: Bool { get set }
}

class CustomTableViewCell: UITableViewCell, ConversationCellConfiguratioin {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    var name: String? {
        get {
            return nameLabel.text!
        }
        set (newVal) {
            nameLabel.text = newVal
        }
    }
    
    var message: String? {
        get {
            return messageLabel.text!
        }
        set (newVal) {
            guard let newValue = newVal else {
                let textForNothing = "No messages yet"
                let myAttributes = [NSAttributedString.Key.font: UIFont(name: "Futura", size: 18.0)!,
                                    NSAttributedString.Key.foregroundColor: UIColor.red]
                let atrTextForNothing = NSAttributedString(string: textForNothing, attributes: myAttributes)
                messageLabel.attributedText = atrTextForNothing
                return
            }
            messageLabel.text = newValue
        }
    }

    var date: Date? {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM-dd-yyyy HH:mm"
            let formdate = dateFormatter.date(from: timeLabel.text ?? "") ?? Date()
            return formdate
        }
        set (newVal) {
            guard let newValue = newVal else {
                print("Error in Date unwrapping")
                return
            }
            guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
                print("Error in yesterday unwrapping")
                return
            }
            if (newValue < yesterday) {
                let outputDateFormatter = DateFormatter()
                outputDateFormatter.dateFormat = "dd MMM"
                timeLabel.text = outputDateFormatter.string(from: newValue)
            } else {
                let outputDateFormatter = DateFormatter()
                outputDateFormatter.dateFormat = "HH:mm"
                timeLabel.text = outputDateFormatter.string(from: newValue)
            }
        }
    }
    
    var online: Bool {
        get {
            return true
        }
        set (newVal) {
            if newVal == true {
                backgroundColor = UIColor.yellow.withAlphaComponent(0.2)
            } else {
                backgroundColor = .clear
            }
        }
    }
    
    var hasUreadMessages: Bool {
        get {
            return true
        }
        set (newVal) {
            if newVal == true {
                messageLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
            } else {
                messageLabel.font = UIFont.systemFont(ofSize: 17.0)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
