//
//  CheckListViewController.swift
//  manageRefrigerator
//
//  Created by suki on 6/1/25.
//

import UIKit
import FirebaseAuth

struct CheckItem: Codable {
    var title: String
    var isChecked: Bool
}

class CheckListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var userID: String {
        return Auth.auth().currentUser?.uid ?? "not"
    }
    
    var checkItems: [CheckItem] = [] // 체크리스트 목록
    
    // 사용자별 키 생성
    func userDefaultsKey(for userID: String) -> String {
        return "checklistItems_\(userID)"
    }

    // 저장
    func saveCheckItems() {
        if let data = try? JSONEncoder().encode(checkItems) {
            UserDefaults.standard.set(data, forKey: userDefaultsKey(for: userID))
        }
    }

    // 조회
    func loadCheckItems() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey(for: userID)),
           let savedItems = try? JSONDecoder().decode([CheckItem].self, from: data) {
            checkItems = savedItems
        } else {
            // 처음 실행 시 빈 항목 1개
            checkItems = [
                CheckItem(title: "", isChecked: false)
            ]
            saveCheckItems()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return checkItems.count
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChecklistCell", for: indexPath) as? ChecklistCollectionViewCell else {
            return UICollectionViewCell()
        }

        let item = checkItems[indexPath.item]
        cell.checkText.text = item.title
        cell.checkButton.isSelected = item.isChecked
        
        if item.isChecked {
            // 체크된 항목은 회색 + 밑줄
            let attributed = NSAttributedString(
                string: item.title,
                attributes: [
                    .foregroundColor: UIColor.lightGray,
                    .strikethroughStyle: NSUnderlineStyle.single.rawValue
                ])
            cell.checkText.attributedText = attributed
        } else {
            // 체크 안 된 항목은 기본 스타일
            cell.checkText.attributedText = NSAttributedString(string: item.title, attributes: [
                .foregroundColor: UIColor.label
            ])
        }
        
        // 체크박스 토글
        cell.checkButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.checkItems[indexPath.item].isChecked.toggle()
            self.saveCheckItems() // 저장
            collectionView.reloadItems(at: [indexPath])
        }
        
        let currentIndex = indexPath.item
        cell.textFieldEdited = { [weak self] newText in
            guard let self = self else { return }
            guard currentIndex < self.checkItems.count else { return }
            self.checkItems[currentIndex].title = newText
            self.saveCheckItems()
        }
        
        // 엔터 -> 새로운 체크리스트
        cell.onEnterPressed = { [weak self] text in
            guard let self = self else { return }
            self.checkItems[indexPath.item].title = text
            self.checkItems.append(CheckItem(title: "", isChecked: false))
            self.saveCheckItems()
            self.collectionView.reloadData()
            
            // 추가된 셀에 focus
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                let newIndex = IndexPath(item: self.checkItems.count - 1, section: 0)
                if let newCell = self.collectionView.cellForItem(at: newIndex) as? ChecklistCollectionViewCell {
                    newCell.focusTextField()
                }
            }
        }
        
        // 삭제
        cell.deleteButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.checkItems.remove(at: indexPath.item)
            
            // 삭제 후 비었으면 빈 항목 추가
            if self.checkItems.isEmpty {
                self.checkItems.append(CheckItem(title: "", isChecked: false))
            }
            
            self.saveCheckItems()
            self.collectionView.reloadData()
        }
        
        if item.title.isEmpty {
            DispatchQueue.main.async {
                cell.focusTextField()
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {

            let inset: CGFloat = 1 // 좌우 여백
            let width = collectionView.bounds.width - inset * 2
            let height: CGFloat = 40  // 한 셀의 높이

            return CGSize(width: width, height: height)
        }

   

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5  // 셀 사이 간격
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(
            UINib(nibName: "ChecklistCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "ChecklistCell"
        )
        
        loadCheckItems() // 체크리스트
        if checkItems.isEmpty {
            checkItems.append(CheckItem(title: "", isChecked: false))
            saveCheckItems()
        }
    }
    
}
