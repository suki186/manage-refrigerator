//
//  RegisterViewController.swift
//  manageRefrigerator
//
//  Created by suki on 5/31/25.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var matTextField: UITextField!
    @IBOutlet weak var matNumField: UITextField!
    @IBOutlet weak var dateContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // TextField 테두리 디자인
        matTextField.layer.borderColor = UIColor(red: 98/255, green: 209/255, blue: 239/255, alpha: 1.0).cgColor
        matTextField.layer.borderWidth = 2.0
        matTextField.layer.cornerRadius = 15.0
        matTextField.clipsToBounds = true
        matNumField.layer.borderColor = UIColor(red: 98/255, green: 209/255, blue: 239/255, alpha: 1.0).cgColor
        matNumField.layer.borderWidth = 2.0
        matNumField.layer.cornerRadius = 15.0
        matNumField.clipsToBounds = true
        dateContainer.layer.borderColor = UIColor(red: 98/255, green: 209/255, blue: 239/255, alpha: 1.0).cgColor
        dateContainer.layer.borderWidth = 2.0
        dateContainer.layer.cornerRadius = 15.0
        dateContainer.clipsToBounds = true
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
