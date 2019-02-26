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
    
    var conversationTitle: String?
    
    var textMessage = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conversationTableView.dataSource = self
        conversationTableView.delegate = self
        self.navigationItem.title = conversationTitle
        conversationTableView.register(UINib.init(nibName: "InputMessageCell", bundle: nil), forCellReuseIdentifier: "inputMessage")
//        conversationTableView.register(UINib.init(nibName: "OutputMessageCell", bundle: nil), forCellReuseIdentifier: "outputMessage")
        conversationTableView.rowHeight = UITableView.automaticDimension
        conversationTableView.estimatedRowHeight = 100.0
    }
    
}

extension ConversationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let inputCell = tableView.dequeueReusableCell(withIdentifier: "inputMessage", for: indexPath) as! InputMessageCell
       // let outputCell = tableView.dequeueReusableCell(withIdentifier: "outputMessage", for: indexPath) as! OutputMessageCell
        inputCell.inputMessageLabel.text = textMessage
        return inputCell
    }
    
    
}
