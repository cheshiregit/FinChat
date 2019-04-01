//
//  ConversationViewController.swift
//  FinChat
//
//  Created by Roman Nordshtrem on 26/02/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController {

    @IBOutlet weak var conversationTableView: UITableView!
    
    let incomingCellIdentifier = "IncomingMessageCell"
    let outgoingCellIdentifier = "OutgoingMessageCell"
    
    var conversationTitle: String?
    
    var textMessage = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conversationTableView.dataSource = self
        conversationTableView.delegate = self
        self.navigationItem.title = conversationTitle
        conversationTableView.rowHeight = UITableView.automaticDimension
        conversationTableView.estimatedRowHeight = 50.0
        self.conversationTableView.separatorColor = UIColor.clear
    }
    
}

extension ConversationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: incomingCellIdentifier) as! ConversationCell
            cell.bubbleImageView.image = UIImage.init(named: "bubble_received")?.resizableImage(withCapInsets:
                UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21),resizingMode: .stretch).withRenderingMode(.alwaysTemplate)
            cell.bubbleImageView.tintColor = UIColor(white: 0.9, alpha: 1)
            cell.messageLabel.text = textMessage
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: outgoingCellIdentifier) as! ConversationCell
            cell.bubbleImageView.image = UIImage.init(named: "bubble_sent")?.resizableImage(withCapInsets:
                UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21),resizingMode: .stretch).withRenderingMode(.alwaysTemplate)
            cell.bubbleImageView.tintColor = UIColor(red:0.08, green:0.49, blue:0.98, alpha:1.0)
            cell.messageLabel.text = textMessage
            return cell
        }
    }
    
    
}
