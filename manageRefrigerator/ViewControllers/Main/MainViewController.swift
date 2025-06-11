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
        [coldLabel, frozenLabel, roomLabel].forEach {
            $0?.layer.cornerRadius = 20
            $0?.clipsToBounds = true
        }
    }
    
    @IBAction func coldButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowItemList", sender: "냉장")
    }
    
    @IBAction func frozenButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowItemList", sender: "냉동")
    }
    
    @IBAction func roomButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowItemList", sender: "실온")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowItemList",
           let destination = segue.destination as? ItemListViewController,
           let location = sender as? String {
            destination.locationType = location
        }
    }
    
}

