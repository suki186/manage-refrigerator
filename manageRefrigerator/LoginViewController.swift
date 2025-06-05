//
//  LoginViewController.swift
//  manageRefrigerator
//
//  Created by suki on 6/6/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var idContainer: UIView!
    @IBOutlet weak var idTextField: UITextField!
    
    @IBOutlet weak var pwContainer: UIView!
    @IBOutlet weak var pwTextField: UITextField!
    
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
    }
    

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let id = idTextField.text ?? ""
        let pw = pwTextField.text ?? ""

        // 임시 계정
        if id == "suki02" && pw == "000000" {
            goToMainTab(index: 2)
        } else {
            // 실패 alert
        }
    }
    
    func goToMainTab(index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // MainTabBarController로 전환
        if let tabBarVC = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
            tabBarVC.selectedIndex = index  // 바로 index 2로 이동

            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = tabBarVC
            }
        }
    }

}
