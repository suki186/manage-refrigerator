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
    
    func configure(with alert: Alert) {
        itemImage.image = UIImage(systemName: "timer")
        itemMessage.text = "[\(alert.category)-\(alert.itemName)]의 소비기한이 2일 남았습니다!"
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
