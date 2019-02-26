//
//  ConversationCell.swift
//  FinChat
//
//  Created by Roman Nordshtrem on 26/02/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

import UIKit

protocol MessageCellConfiguratioin: class {
    var text: String? { get set }
}

class ConversationCell: UIViewController, MessageCellConfiguratioin {
    
    var text: String? {
        get {
            return ""
        }
        set (newVal) {
            
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //let inputCell = InputMessageCell()
        //let outputCell = OutputMessageCell()
    }

}

