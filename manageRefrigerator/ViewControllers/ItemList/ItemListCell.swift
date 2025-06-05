//
//  ItemListCell.swift
//  manageRefrigerator
//
//  Created by suki on 6/5/25.
//

import UIKit

class ItemListCell: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemCount: UILabel!
    @IBOutlet weak var itemDate: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    private var quantity: Int = 0 // 현재 수량
    
    func configure(with item: Ingredient) {
        itemImage.image = UIImage(named: item.imageName)
        itemName.text = item.name
        quantity = item.quantity
        itemCount.text = "\(quantity)"
        itemDate.text = item.expireDate
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didTapMinus(_ sender: UIButton) {
        if quantity > 1 { // 최소 1
            quantity -= 1
            itemCount.text = "\(quantity)"
            }
    }
    
    @IBAction func didTapPlus(_ sender: UIButton) {
        quantity += 1
        itemCount.text = "\(quantity)"
    }
    
}
