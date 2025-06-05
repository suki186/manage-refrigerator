//
//  RecomRecipeViewController.swift
//  manageRefrigerator
//
//  Created by suki on 6/4/25.
//

import UIKit

struct Recipe {
    let title: String
    let imageName: String
}

class RecomRecipeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let recipes: [Recipe] = [
        Recipe(title: "김치볶음밥", imageName: "mat1"),
        Recipe(title: "된장찌개", imageName: "mat2"),
        Recipe(title: "김치볶음밥", imageName: "mat1"),
        Recipe(title: "된장찌개", imageName: "mat2"),
        Recipe(title: "김치볶음밥", imageName: "mat1"),
        Recipe(title: "된장찌개", imageName: "mat2"),
        Recipe(title: "김치볶음밥", imageName: "mat1"),
        Recipe(title: "된장찌개", imageName: "mat2"),
        Recipe(title: "김치볶음밥", imageName: "mat1"),
        Recipe(title: "된장찌개", imageName: "mat2"),
        Recipe(title: "김치볶음밥", imageName: "mat1"),
        Recipe(title: "된장찌개", imageName: "mat2"),
        Recipe(title: "김치볶음밥", imageName: "mat1"),
        Recipe(title: "된장찌개", imageName: "mat2"),
    ]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecRecipeCardCell", for: indexPath) as? RecRecipeCardCollectionViewCell else {
                return UICollectionViewCell()
            }
            let recipe = recipes[indexPath.item]
            cell.configure(with: recipe)
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 165, height: 140)  // 셀 크기
    }

    
    @IBOutlet weak var MyRecipeButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        MyRecipeButton.layer.shadowColor = UIColor.black.cgColor
        MyRecipeButton.layer.shadowOpacity = 0.2
        MyRecipeButton.layer.shadowOffset = CGSize(width: 0, height: -2)
        MyRecipeButton.layer.shadowRadius = 10
        MyRecipeButton.layer.masksToBounds = false
        
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(
            UINib(nibName: "RecRecipeCardCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "RecRecipeCardCell"
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
