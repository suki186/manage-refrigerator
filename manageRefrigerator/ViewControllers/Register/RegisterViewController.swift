//
//  RegisterViewController.swift
//  manageRefrigerator
//
//  Created by suki on 5/31/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

struct CategoryItem {
    let title: String
    let imageName: String
}

class RegisterViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var selectedDate: Date?
    var selectedCategory: CategoryItem?
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = categories[indexPath.item]
        //print("카테고리 선택됨: \(selectedCategory!.title)")
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
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var dataLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // TextField 테두리 디자인
        let borderColor = UIColor(red: 98/255, green: 209/255, blue: 239/255, alpha: 1.0)

        [matTextField, matNumField, dateContainer].forEach { view in
            view?.layer.borderColor = borderColor.cgColor
            view?.layer.borderWidth = 2.0
            view?.layer.cornerRadius = 15.0
            view?.clipsToBounds = true
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = false
        collectionView.register(
            UINib(nibName: "CategoryCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "CategoryCell"
        )

    }
    
    // 폼 초기화
    func resetForm() {
        matTextField.text = ""
        matNumField.text = ""
        selectedCategory = nil
        selectedDate = nil
        dataLabel.text = "날짜 선택"
        collectionView.reloadData()
    }
    
    @IBAction func selectLocation(_ sender: UISegmentedControl) {
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        // Null 검사
        guard let uid = Auth.auth().currentUser?.uid else {
            showAlert(title: "로그인 오류", message: "로그인이 필요합니다.")
            return
        }
        guard let name = matTextField.text, !name.isEmpty else {
            showAlert(title: "입력 오류", message: "재료 이름을 입력해주세요.")
            return
        }
        guard let countString = matNumField.text, let count = Int(countString) else {
            showAlert(title: "입력 오류", message: "개수를 숫자로 입력해주세요.")
            return
        }
        guard let category = selectedCategory?.title else {
            showAlert(title: "선택 오류", message: "카테고리를 선택해주세요.")
            return
        }
        guard let expirationDate = selectedDate else {
            showAlert(title: "선택 오류", message: "소비기한을 선택해주세요.")
            return
        }

        let storageType = ["냉장", "냉동", "실온"][segmentControl.selectedSegmentIndex] // 위치 선택

        let data: [String: Any] = [ // 저장할 데이터
            "name": name, // 이름
            "count": count, // 개수
            "category": category, // 카테고리
            "expiration": Timestamp(date: expirationDate) // 소비기한
        ]

        let db = Firestore.firestore()
        db.collection("users").document(uid).collection(storageType).addDocument(data: data) { error in
            if let error = error {
                self.showAlert(title: "등록 실패", message: error.localizedDescription)
            } else {
                self.showAlert(title: "등록 완료!", message: "\(name)이(가) \(storageType)에 등록되었습니다.") {
                    self.resetForm()
                }
                //self.dismiss(animated: true)
            }
        }
    }
    
    @IBAction func dataButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "날짜 선택", message: "\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
            
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.date = Date() // 오늘로 초기화
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.frame = CGRect(x: 0, y: 20, width: alert.view.bounds.width - 20, height: 200)
        datePicker.locale = Locale(identifier: "ko_KR") // 한국어
        
        alert.view.addSubview(datePicker)
        
        let selectAction = UIAlertAction(title: "선택", style: .default) { _ in
            self.selectedDate = datePicker.date
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.dd."
            self.dataLabel.text = formatter.string(from: datePicker.date)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(selectAction)
        alert.addAction(cancelAction)
        
        // iPad 대응 (iOS 14 이상에서 충돌 방지)
        if let popover = alert.popoverPresentationController {
            popover.sourceView = sender
            popover.sourceRect = sender.bounds
        }

        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func minusButtonTapped(_ sender: UIButton) {
        let current = Int(matNumField.text ?? "") ?? 0
        let newValue = max(current - 1, 1) // 1 이하로 안 내려가게
        matNumField.text = "\(newValue)"
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        let current = Int(matNumField.text ?? "") ?? 0
        let newValue = current + 1
        matNumField.text = "\(newValue)"
    }
    

}
