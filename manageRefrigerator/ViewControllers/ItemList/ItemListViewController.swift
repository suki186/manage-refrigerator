//
//  ItemListViewController.swift
//  manageRefrigerator
//
//  Created by suki on 6/5/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

struct Ingredient {
    let docID: String
    let imageName: String   // 이미지
    let name: String        // 재료명
    let quantity: Int       // 개수
    let expireDate: String  // 소비기한
}

class ItemListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ItemListCellDelegate {
    
    var locationType: String = "" // 위치(냉장, 냉동, 실온)
    var items: [Ingredient] = [] // 재료 목록
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemListCell", for: indexPath) as? ItemListCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: item)
        cell.delegate = self // delegate 연결
        return cell
    }
    
    // 개수 업데이트하는 delegate 함수
    func didUpdateQuantity(for item: Ingredient, to newQuantity: Int) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        
        let ref = db.collection("users").document(uid).collection(locationType).document(item.docID)
        
        ref.updateData(["count": newQuantity]) { error in
            if let error = error {
                print("개수 업데이트 실패: \(error.localizedDescription)")
            } else {
                print("개수 업데이트 성공: \(item.name) → \(newQuantity)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        let ingredient = items[indexPath.row]
                
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        let ref = db.collection("users").document(uid).collection(locationType).document(ingredient.docID)
        
        ref.delete { error in
            if let error = error {
                print("Firestore 삭제 실패: \(error.localizedDescription)")
            } else {
                print("Firestore 삭제 성공")
                self.items.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }

    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationLabel.text = locationType

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
        
        fetchDataFromFirestore()

    }
    
    func fetchDataFromFirestore() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        let ref = db.collection("users").document(uid).collection(locationType)
        
        ref.getDocuments { snapshot, error in
            if let error = error {
                print("Firestore fetch error: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            
            self.items = documents.compactMap { doc -> Ingredient? in
                let data = doc.data()
                guard let name = data["name"] as? String,
                      let count = data["count"] as? Int,
                      let category = data["category"] as? String,
                      let timestamp = data["expiration"] as? Timestamp else {
                    return nil
                }
                
                // 카테고리 → 이미지 이름 매핑
                let imageName = self.imageName(for: category)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yy.MM.dd"
                let expireDate = dateFormatter.string(from: timestamp.dateValue())
                
                return Ingredient(docID: doc.documentID, imageName: imageName, name: name, quantity: count, expireDate: expireDate)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func imageName(for category: String) -> String {
        let map: [String: String] = [
            "채소": "mat1", "과일": "mat2", "육류": "mat3", "수산물": "mat4",
            "유제품": "mat5", "계란/콩": "mat6", "가공식품": "mat7", "조미료": "mat8",
            "음료": "mat9", "향신료": "mat10", "완제품": "mat11", "기타": "mat12"
        ]
        return map[category] ?? "mat12"
    }


}
