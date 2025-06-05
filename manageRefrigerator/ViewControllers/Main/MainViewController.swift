//
//  MainViewController.swift
//  manageRefrigerator
//
//  Created by suki on 5/31/25.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var coldLabel: UILabel!
    @IBOutlet weak var frozenLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Label 테두리
        coldLabel.layer.cornerRadius = 20
        coldLabel.clipsToBounds = true
        frozenLabel.layer.cornerRadius = 20
        frozenLabel.clipsToBounds = true
        roomLabel.layer.cornerRadius = 20
        roomLabel.clipsToBounds = true
    }


}

