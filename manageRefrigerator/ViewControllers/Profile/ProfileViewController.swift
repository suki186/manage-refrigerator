//
//  ProfileViewController.swift
//  manageRefrigerator
//
//  Created by suki on 6/1/25.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var IdLabel: UILabel!
    @IBOutlet weak var InfoContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 테두리 디자인
        IdLabel.layer.borderColor = UIColor(red: 98/255, green: 209/255, blue: 239/255, alpha: 1.0).cgColor
        IdLabel.layer.borderWidth = 2.0
        IdLabel.layer.cornerRadius = 15.0
        IdLabel.clipsToBounds = true
        
        InfoContainer.layer.cornerRadius = 20.0
        InfoContainer.clipsToBounds = true

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
