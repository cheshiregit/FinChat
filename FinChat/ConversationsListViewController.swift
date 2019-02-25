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
        
        let isoDate = "November-25-2017 22:04"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM-dd-yyyy HH:mm"
        let formdate = dateFormatter.date(from: isoDate) ?? Date()
        
        let cellExp1 = CellModel(name: "Bob", message: "Hello", date: formdate, online: true, hasUnreadMessages: false)
        let cellExp2 = CellModel(name: "John", message: "Some text", date: formdate, online: true, hasUnreadMessages: true)
        let cellExp3 = CellModel(name: "Anne", message: "Once upon a time", date: formdate, online: false, hasUnreadMessages: false)
        let cellExp4 = CellModel(name: "Tom", message: "Storyboard-based application", date: formdate, online: true, hasUnreadMessages: true)
        let cellExp5 = CellModel(name: "Liza", message: "Override func prepare", date: formdate, online: true, hasUnreadMessages: false)
        cells.append(cellExp1)
        cells.append(cellExp2)
        cells.append(cellExp3)
        cells.append(cellExp4)
        cells.append(cellExp5)
//        CellModel(name: "Bob", message: "Hello", date: date, online: true, hasUnreadMessages: false)
    }
    
    var cells = [CellModel]()
    
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
            return cells.count
        case 1:
            return cells.count
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
        cell.name = cells[indexPath.row].name
        cell.message = cells[indexPath.row].message
        cell.date = cells[indexPath.row].date
        cell.online = cells[indexPath.row].online
        cell.hasUreadMessages = cells[indexPath.row].hasUreadMessages
        return cell as! UITableViewCell
    }
}
