//
//  CheckListViewController.swift
//  manageRefrigerator
//
//  Created by suki on 6/1/25.
//

import UIKit

struct CheckItem {
    var title: String
    var isChecked: Bool
}

class CheckListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var checkItems: [CheckItem] = [
        CheckItem(title: "계란 한판", isChecked: false),
        CheckItem(title: "우유 500ml", isChecked: true),
        CheckItem(title: "당근 1봉지", isChecked: false)
    ]
    
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
