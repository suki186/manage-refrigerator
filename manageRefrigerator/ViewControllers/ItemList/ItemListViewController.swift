//
//  ItemListViewController.swift
//  manageRefrigerator
//
//  Created by suki on 6/5/25.
//

import UIKit

struct Ingredient {
    let imageName: String   // 이미지
    let name: String        // 재료명
    let quantity: Int       // 개수
    let expireDate: String  // 소비기한
}

class ItemListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // 예시 데이터
    var items: [Ingredient] = [
        Ingredient(imageName: "mat1", name: "당근", quantity: 3, expireDate: "25.06.01"),
        Ingredient(imageName: "mat5", name: "우유", quantity: 1, expireDate: "25.06.10")
    ]

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemListCell", for: indexPath) as? ItemListCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // items 배열에서 삭제
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let borderColor = UIColor(red: 98/255, green: 209/255, blue: 239/255, alpha: 1.0)

        [nameLabel, countLabel, dateLabel].forEach { view in
            view?.layer.borderColor = borderColor.cgColor
            view?.layer.borderWidth = 2.0
            view?.layer.cornerRadius = 15.0
            view?.clipsToBounds = true
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = borderColor


    }


}
