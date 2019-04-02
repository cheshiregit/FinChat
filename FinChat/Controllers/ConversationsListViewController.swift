//
//  ConversationsListViewController.swift
//  FinChat
//
//  Created by Roman Nordshtrem on 25/02/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

import UIKit

protocol ConversationsListDelegate : class {
    
    func reloadTableView()
}

class ConversationsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var communicationManager: CommunicationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 64.0
        
        self.communicationManager = CommunicationManager()
        self.communicationManager?.delegate = self
        
        //self.view.backgroundColor = savedTheme()
        self.navigationController?.navigationBar.barTintColor = savedTheme()
        UINavigationBar.appearance().barTintColor = savedTheme()
        
        self.sortDialogs()
        self.tableView.reloadData()
    }
    
    func sortDialogs() {
        self.cellsOnline = self.cellsOnline.sorted(by: { $0.date?.compare($1.date!) == .orderedDescending })
        self.dialogCells.removeAll()
        self.dialogCells.append(cellsOnline)
    }
    
    var cellsOnline = [CellModel]()
    var cellsOffline = [CellModel]()
    
    var dialogCells = [[CellModel]]()
    
    let savedTheme = { () -> UIColor? in
        
        var theme: UIColor?
        if let themeData = UserDefaults.standard.colorForKey(key: "Theme") {
            theme = themeData
        } else {
            theme = UIColor.white
        }
        
        return theme
    }
    
}

extension ConversationsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return cellsOnline.count
        case 1:
            return cellsOffline.count
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Online"
        case 1:
            return "History"
        default:
            break
        }
        return "Error"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier", for: indexPath) as! ConversationCellConfiguratioin
        if indexPath.section == 0 {
            cell.name = cellsOnline[indexPath.row].name
            cell.message = cellsOnline[indexPath.row].message.first?.text
            cell.date = cellsOnline[indexPath.row].date
            cell.online = cellsOnline[indexPath.row].online
            cell.hasUreadMessages = cellsOnline[indexPath.row].hasUnreadMessages
        } else {
            cell.name = cellsOffline[indexPath.row].name
            cell.message = cellsOffline[indexPath.row].message.first?.text
            cell.date = cellsOffline[indexPath.row].date
            cell.online = cellsOffline[indexPath.row].online
            cell.hasUreadMessages = cellsOffline[indexPath.row].hasUnreadMessages
        }
        return cell as! UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let personName = cellsOnline[indexPath.row].name
//        performSegue(withIdentifier: "showConversation", sender: personName)
        
        if indexPath.section == 0 {
            dialogCells[indexPath.section][indexPath.row].hasUnreadMessages = false
        }
        
        performSegue(withIdentifier: "showConversation", sender: dialogCells[indexPath.section][indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print(segue.destination) themesSegue
        switch segue.identifier {
        case "showConversation":
            guard let vc = segue.destination as? ConversationViewController else { return }
            guard let dialog = sender as? CellModel? else { return }
            vc.conversationTitle = dialog?.name
            vc.dialog = dialog
            vc.delegate = self
            vc.idUserTo = dialog?.userID
            vc.messages = (dialog?.message)!
        case "themesSegue":
            guard let vc = segue.destination as? ThemesViewControllerSwift else { return }
            vc.themesClosure = { theme in
                self.logThemeChanging(selectedTheme: theme)
            }
            
        default:
            return
        }
    }
    
    func logThemeChanging(selectedTheme: UIColor) {
        print("Theme is \(selectedTheme)")
    }
    
}

extension ConversationsListViewController: ThemesViewControllerDelegate {
    func themesViewController(_ controller: ThemesViewController, didSelectTheme selectedTheme: UIColor) {
        logThemeChanging(selectedTheme: selectedTheme)
    }
}

extension ConversationsListViewController: CommunicationManagerDelegate {
    
    func didReceiveMessageInDialogList(text: String, fromUser: String) {
        
        if let dialog = self.cellsOnline.filter( {$0.userID == fromUser }).first {
            self.cellsOnline = self.cellsOnline.filter( {$0.userID != fromUser} )
            dialog.message.append(MessageModel(text: text, isIncoming: true))
            dialog.hasUnreadMessages = true
            self.cellsOnline.append(dialog)
            sortDialogs()
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.communicationManager?.delegate?.didUpdateDialogList(dialogs: self.cellsOnline) //need?
            }
        }
        
    }
    
    func didUpdateDialogList(dialogs: [CellModel]) {
        self.cellsOnline.removeAll()
        self.cellsOffline.removeAll()
        self.dialogCells.removeAll()
        
        for dialog in dialogs {
            if dialog.online {
                self.cellsOnline.append(dialog)
            } else {
                self.cellsOffline.append(dialog)
            }
        }
        self.dialogCells.append(cellsOnline)
        self.dialogCells.append(cellsOffline)
        self.tableView.reloadData()
    }
    
}

extension ConversationsListViewController: ConversationsListDelegate {
    
    func reloadTableView() {
        self.sortDialogs()
        self.tableView.reloadData()
    }
    
    
}
