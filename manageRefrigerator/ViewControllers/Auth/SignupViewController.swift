//
//  SignupViewController.swift
//  manageRefrigerator
//
//  Created by suki on 6/6/25.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var idContainer: UIView!
    @IBOutlet weak var idTextField: UITextField!
    
    @IBOutlet weak var pwContainer: UIView!
    @IBOutlet weak var pwTextField: UITextField!
    
    @IBOutlet weak var rpwContainer: UIView!
    @IBOutlet weak var rpwTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        idContainer.layer.cornerRadius = 20
        idContainer.clipsToBounds = true
        idTextField.backgroundColor = .clear
        idTextField.borderStyle = .none
        
        pwContainer.layer.cornerRadius = 20
        pwContainer.clipsToBounds = true
        pwTextField.backgroundColor = .clear
        pwTextField.borderStyle = .none
        
        rpwContainer.layer.cornerRadius = 20
        rpwContainer.clipsToBounds = true
        rpwTextField.backgroundColor = .clear
        rpwTextField.borderStyle = .none
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
