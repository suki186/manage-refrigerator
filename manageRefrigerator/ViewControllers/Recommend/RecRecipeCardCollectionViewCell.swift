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
        imageName.text = recipe.title
        
        // API에서 받은 이미지 URL 로드
        if !recipe.imageUrl.isEmpty {
            loadImage(from: recipe.imageUrl)
        } else {
            imageView.image = UIImage(named: "noimage")
        }
    }
    
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            imageView.image = UIImage(named: "noimage")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("이미지 로드 에러: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(named: "noimage")
                }
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(named: "noimage")
                }
                return
            }
            
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }.resume()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        imageName.text = nil
    }

}
