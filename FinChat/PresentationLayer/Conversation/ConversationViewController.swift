//
//  ConversationViewController.swift
//  FinChat
//
//  Created by Roman Nordshtrem on 26/02/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

import UIKit

protocol ConversationDelegate: class {

    func didReceiveMessage(text: String, fromUser: String)
}

protocol ChangeUserState: class {

    func userOffline(userId: String)
    func userOnline(userId: String)

}

class ConversationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var conversationTableView: UITableView!
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet var sendMessageButton: UIButton!

    var conversationTitle: String?

    let incomingCellIdentifier = "IncomingMessageCell"
    let outgoingCellIdentifier = "OutgoingMessageCell"

    var messages = [MessageModel]()
    var communicationManager: CommunicationManager?
    var dialog: CellModel?
    var idUserTo: String?

    weak var delegate: ConversationsListDelegate?

    var textMessage = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    
    var sendButtonEnabled = true
    
    var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: 24))
        label.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        label.textAlignment = .center
        return label
    }()

    @IBAction func sendButtonClick(_ sender: Any) {
        sendButtonChangeState(state: false)
        self.communicationManager?.communicator?.sendMessage(string: self.messageTextField.text!,
                                                             to: idUserTo!,
                                                             completionHandler: { success, _ in
                                                                if success {
                                                                    self.sendMessage(text: self.messageTextField.text!)
                                                                } else {
                                                                    print("error")
                                                                }
        })
    }
    
    func sendMessage(text: String) {
        let message = MessageModel(text: text, isIncoming: false)

        self.messages.append(message)

        self.conversationTableView.reloadData()
        self.messageTextField.text = ""

        self.dialog?.message = self.messages

        DispatchQueue.main.async {
            self.delegate?.reloadTableView()
            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
            self.conversationTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func sendButtonChangeState(state: Bool, withAnimation: Bool = true) {
        if sendButtonEnabled != state {
            sendButtonEnabled = state
            self.sendMessageButton.isEnabled = state
            if !state {
//                self.sendMessageButton.alpha = 0.7
                self.sendMessageButton.tintColor = UIColor.white
                if withAnimation {
                    animation(state: state)
                }
            } else {
//                self.sendMessageButton.alpha = 1
                self.sendMessageButton.tintColor = UIColor.blue
                animation(state: state)
            }
        }
    }
    
    func animation(state: Bool) {
        UIView.animate(withDuration: 0.5, animations: { self.sendMessageButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15) },
                       completion: { _ in
                        UIView.animate(withDuration: 0.6) {
                            self.sendMessageButton.transform = CGAffineTransform.identity
                        }
        })
        UIView.animate(withDuration: 1.0) {
            if state == true {
                self.sendMessageButton.layer.backgroundColor =  UIColor.clear.cgColor
            } else {
                self.sendMessageButton.layer.backgroundColor =  UIColor.lightGray.cgColor
            }
        }
    }
    
    @objc func textFieldEdited() {
        if !messageTextField.text!.isEmpty {
            sendButtonChangeState(state: true)
        } else {
            sendButtonChangeState(state: false)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        conversationTableView.dataSource = self
        conversationTableView.delegate = self
        self.navigationItem.title = conversationTitle
        conversationTableView.rowHeight = UITableView.automaticDimension
        conversationTableView.estimatedRowHeight = 50.0
        conversationTableView.separatorStyle = .none
        //
        self.communicationManager = CommunicationManager()
        self.messageTextField.delegate = self
        self.communicationManager?.conversationDelegate = self
        //
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldEdited),
                                               name: UITextField.textDidChangeNotification, object: messageTextField)
        let notifier = NotificationCenter.default
        notifier.addObserver(self,
                             selector: #selector(EditProfileViewController.keyboardWillShowNotification(_:)),
                             name: UIWindow.keyboardWillShowNotification,
                             object: nil)
        notifier.addObserver(self,
                             selector: #selector(EditProfileViewController.keyboardWillHideNotification(_:)),
                             name: UIWindow.keyboardWillHideNotification,
                             object: nil)
        //
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        messageTextField.delegate = self
        sendButtonChangeState(state: false, withAnimation: false)
        
        
        self.changeUserStatus(status: true)
        self.navigationItem.titleView = titleLabel
        titleLabel.text = conversationTitle
    }

    deinit {
        self.communicationManager = nil
    }

    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        messageTextField.endEditing(true)
    }

    @objc func keyboardWillShowNotification(_ notification: NSNotification) {
        print("keyboardWillShow")
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            self.view.frame.origin.y = -1.0 * keyboardHeight
        }
    }

    @objc func keyboardWillHideNotification(_ notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
}

extension ConversationViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return configureCell(tableView: tableView, message: messages[indexPath.row])
    }

    func configureCell(tableView: UITableView, message: MessageModel) -> UITableViewCell {
        if message.isIncoming {
            if let cell = tableView.dequeueReusableCell(withIdentifier: incomingCellIdentifier) as? ConversationCell {
                cell.bubbleImageView.image = UIImage.init(named: "bubble_received")?.resizableImage(withCapInsets:
                    UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21), resizingMode: .stretch).withRenderingMode(.alwaysTemplate)
                cell.bubbleImageView.tintColor = UIColor(white: 0.9, alpha: 1)
                cell.messageLabel.text = message.text
                return cell
            } else {
                return UITableViewCell()
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: outgoingCellIdentifier) as? ConversationCell {
                cell.bubbleImageView.image = UIImage.init(named: "bubble_sent")?.resizableImage(withCapInsets:
                    UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21), resizingMode: .stretch).withRenderingMode(.alwaysTemplate)
                cell.bubbleImageView.tintColor = UIColor(red: 0.08, green: 0.49, blue: 0.98, alpha: 1.0)
                cell.messageLabel.text = message.text
                return cell
            } else {
                return UITableViewCell()
            }
        }
    }

}

extension ConversationViewController: ConversationDelegate {

    func didReceiveMessage(text: String, fromUser: String) {
        if fromUser == idUserTo {
            let newMessage = MessageModel(text: text, isIncoming: true)
            self.messages.append(newMessage)
            self.dialog?.message = self.messages
            DispatchQueue.main.async {
                self.conversationTableView.reloadData()
                self.delegate?.reloadTableView()
            }
        }
    }

}

extension ConversationViewController: ChangeUserState {
    
    func changeUserStatus(status: Bool) {
        print("Change!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        if status {
            UIView.animate(withDuration: 1.0) {
                self.titleLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                self.titleLabel.textColor = UIColor.green
            }
        } else {
            UIView.animate(withDuration: 1.0) {
                self.titleLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.titleLabel.textColor = UIColor.black
            }
        }
    }

    func userOffline(userId: String) {
        print("USER OFFLINE \(userId) !!!!!!!!!!!!!!!!!!!!")
        if userId == self.idUserTo {
            self.sendMessageButton.isEnabled = false
            self.changeUserStatus(status: false)
        }
    }

    func userOnline(userId: String) {
        if userId == self.idUserTo {
            self.sendMessageButton.isEnabled = true
            self.changeUserStatus(status: true)
        }
    }

}
