//
//  RegisterViewController.swift
//  manageRefrigerator
//
//  Created by suki on 5/31/25.
//

import UIKit

struct CategoryItem {
    let title: String
    let imageName: String
}

class RegisterViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = categories[indexPath.item]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
            cell.configure(with: item)
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 75)  // 셀 크기
    }

    
    
    let categories: [CategoryItem] = [
        CategoryItem(title: "채소", imageName: "mat1"),
        CategoryItem(title: "과일", imageName: "mat2"),
        CategoryItem(title: "육류", imageName: "mat3"),
        CategoryItem(title: "수산물", imageName: "mat4"),
        CategoryItem(title: "유제품", imageName: "mat5"),
        CategoryItem(title: "계란/콩", imageName: "mat6"),
        CategoryItem(title: "가공식품", imageName: "mat7"),
        CategoryItem(title: "조미료", imageName: "mat8"),
        CategoryItem(title: "음료", imageName: "mat9"),
        CategoryItem(title: "향신료", imageName: "mat10"),
        CategoryItem(title: "완제품", imageName: "mat11"),
        CategoryItem(title: "기타", imageName: "mat12")
    ]
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var matTextField: UITextField!
    @IBOutlet weak var matNumField: UITextField!
    @IBOutlet weak var dateContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // TextField 테두리 디자인
        matTextField.layer.borderColor = UIColor(red: 98/255, green: 209/255, blue: 239/255, alpha: 1.0).cgColor
        matTextField.layer.borderWidth = 2.0
        matTextField.layer.cornerRadius = 15.0
        matTextField.clipsToBounds = true
        matNumField.layer.borderColor = UIColor(red: 98/255, green: 209/255, blue: 239/255, alpha: 1.0).cgColor
        matNumField.layer.borderWidth = 2.0
        matNumField.layer.cornerRadius = 15.0
        matNumField.clipsToBounds = true
        dateContainer.layer.borderColor = UIColor(red: 98/255, green: 209/255, blue: 239/255, alpha: 1.0).cgColor
        dateContainer.layer.borderWidth = 2.0
        dateContainer.layer.cornerRadius = 15.0
        dateContainer.clipsToBounds = true
        
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(
            UINib(nibName: "CategoryCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "CategoryCell"
        )

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
