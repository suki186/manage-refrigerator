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
    
    func configure(title: String, imageUrl: String) {
        imageName.text = title
        if let url = URL(string: imageUrl) {

            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }
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
