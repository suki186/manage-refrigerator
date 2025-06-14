//
//  AlertListCell.swift
//  manageRefrigerator
//
//  Created by suki on 6/5/25.
//

import UIKit

class AlertListCell: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemMessage: UILabel!
    
    func configure(with item: ExpiringItem) {
        itemImage.image = UIImage(systemName: "timer")
        
        let deadlineText: String
        let color: UIColor
        
        switch item.daysLeft {
        case 2:
            deadlineText = "2일 남았습니다!"
            color = .systemYellow
        case 0:
            deadlineText = "오늘까지예요!"
            color = .systemRed
        default:
            deadlineText = "임박!"
            color = .systemGray
        }

        itemMessage.text = "[\(item.category) - \(item.itemName)]의 소비기한이 \(deadlineText)"
        itemImage.tintColor = color
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        // cell 간 간격
        let inset: CGFloat = 5
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: inset, left: 0, bottom: inset, right: 0))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = UIColor(red: 226/255, green: 251/255, blue: 255/255, alpha: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
