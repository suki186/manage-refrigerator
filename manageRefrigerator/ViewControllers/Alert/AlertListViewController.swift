//
//  AlertListViewController.swift
//  manageRefrigerator
//
//  Created by suki on 6/5/25.
//

import UIKit

struct Alert {
    let category: String
    let itemName: String
}

class AlertListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    // 예시 데이터
    var alerts: [Alert] = [
        Alert(category: "냉장", itemName: "당근"),
        Alert(category: "냉장", itemName: "파프리카"),
        Alert(category: "냉동", itemName: "초콜릿"),
        Alert(category: "실온", itemName: "감자")
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alerts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = alerts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlertCell", for: indexPath) as! AlertListCell
                cell.configure(with: message)
                return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 배열에서 삭제
            alerts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 60
    }
    
    @IBAction func deleteAllAlerts(_ sender: UIButton) {
        let alert = UIAlertController(title: "전체 삭제", message: "모든 알림을 삭제하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
            self.alerts.removeAll()
            self.tableView.reloadData()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    

}
