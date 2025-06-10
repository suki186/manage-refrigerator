//
//  CategoryCollectionViewCell.swift
//  manageRefrigerator
//
//  Created by suki on 6/4/25.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryText: UILabel!
    
    func configure(with item: CategoryItem) {
        categoryImage.image = UIImage(named: item.imageName)
        categoryText.text = item.title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
    }
    
    // 선택 효과
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.layer.borderColor = UIColor(red: 98/255, green: 209/255, blue: 239/255, alpha: 1.0).cgColor
                contentView.layer.borderWidth = 2
            } else {
                contentView.layer.borderColor = UIColor.clear.cgColor
                contentView.layer.borderWidth = 0
            }
        }
    }

}
