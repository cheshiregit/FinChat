//
//  ConversationsListViewController.swift
//  FinChat
//
//  Created by Roman Nordshtrem on 25/02/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

import UIKit

class ConversationsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 64.0
        
        let isoDate = "November-25-2017 22:04"
        let isoDate2 = "February-27-2019 21:04"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM-dd-yyyy HH:mm"
        let formdate = dateFormatter.date(from: isoDate) ?? Date()
        let formdate2 = dateFormatter.date(from: isoDate2) ?? Date()
        
        let cellExp1 = CellModel(name: "User 1", message: "Hello", date: formdate, online: true, hasUnreadMessages: false)
        let cellExp2 = CellModel(name: "User 2", message: "Some text", date: formdate, online: true, hasUnreadMessages: true)
        let cellExp3 = CellModel(name: "User 3", message: "Once upon a time", date: formdate2, online: true, hasUnreadMessages: false)
        let cellExp4 = CellModel(name: "User 4", message: "Storyboard-based application", date: formdate, online: true, hasUnreadMessages: true)
        let cellExp5 = CellModel(name: "User 5", message: "In a storyboard-based application, you will often want to do a little preparation before navigation", date: formdate2, online: true, hasUnreadMessages: false)
        let cellExp6 = CellModel(name: "User 6", message: "Hello", date: formdate, online: false, hasUnreadMessages: false)
        let cellExp7 = CellModel(name: "User 7", message: "Some text", date: formdate, online: false, hasUnreadMessages: true)
        let cellExp8 = CellModel(name: "User 8", message: nil, date: formdate2, online: false, hasUnreadMessages: false)
        let cellExp9 = CellModel(name: "User 9", message: "Storyboard-based application", date: formdate, online: false, hasUnreadMessages: true)
        let cellExp10 = CellModel(name: "User 10", message: "In a storyboard-based application, you will often want to do a little preparation before navigation", date: formdate2, online: false, hasUnreadMessages: false)
        let cellExp0 = CellModel(name: "User 3", message: nil, date: formdate2, online: true, hasUnreadMessages: false)
        cellsOnline.append(cellExp1)
        cellsOnline.append(cellExp2)
        cellsOnline.append(cellExp3)
        cellsOnline.append(cellExp4)
        cellsOnline.append(cellExp5)
        cellsOnline.append(cellExp3)
        cellsOnline.append(cellExp0)
        cellsOnline.append(cellExp0)
        cellsOnline.append(cellExp3)
        cellsOnline.append(cellExp3)
        cellsOffline.append(cellExp6)
        cellsOffline.append(cellExp7)
        cellsOffline.append(cellExp8)
        cellsOffline.append(cellExp9)
        cellsOffline.append(cellExp10)
        cellsOffline.append(cellExp7)
        cellsOffline.append(cellExp7)
        cellsOffline.append(cellExp7)
        cellsOffline.append(cellExp7)
        cellsOffline.append(cellExp7)
    }
    
    var cellsOnline = [CellModel]()
    var cellsOffline = [CellModel]()
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
            cell.message = cellsOnline[indexPath.row].message
            cell.date = cellsOnline[indexPath.row].date
            cell.online = cellsOnline[indexPath.row].online
            cell.hasUreadMessages = cellsOnline[indexPath.row].hasUreadMessages
        } else {
            cell.name = cellsOffline[indexPath.row].name
            cell.message = cellsOffline[indexPath.row].message
            cell.date = cellsOffline[indexPath.row].date
            cell.online = cellsOffline[indexPath.row].online
            cell.hasUreadMessages = cellsOffline[indexPath.row].hasUreadMessages
        }
        return cell as! UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let personName = cellsOnline[indexPath.row].name
        performSegue(withIdentifier: "showConversation", sender: personName)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print(segue.destination)
        guard let vc = segue.destination as? ConversationViewController else { return }
        guard let personName = sender as? String? else { return }
        vc.conversationTitle = personName
    }
}
