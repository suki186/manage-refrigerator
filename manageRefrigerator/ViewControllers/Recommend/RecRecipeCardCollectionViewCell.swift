//
//  RecRecipeCardCollectionViewCell.swift
//  manageRefrigerator
//
//  Created by suki on 6/4/25.
//

import UIKit

class RecRecipeCardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageName: UILabel!
    
    func configure(with recipe: Recipe) {
        imageView.image = UIImage(named: recipe.imageName)
        imageName.text = recipe.title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }

}
