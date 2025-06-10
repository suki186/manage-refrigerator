//
//  LoginViewController.swift
//  manageRefrigerator
//
//  Created by suki on 6/6/25.
//

import UIKit
import FirebaseAuth

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
        let email = idTextField.text ?? ""
        let password = pwTextField.text ?? ""

        // 입력 검증
        guard !email.isEmpty, !password.isEmpty else {
            showAlert(title: "입력 오류", message: "이메일과 비밀번호를 입력해주세요.")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                // 로그인 실패
                print("로그인 실패: \(error.localizedDescription)")
                self?.showAlert(title: "로그인 실패", message: "이메일 또는 비밀번호가 올바르지 않습니다.")
            } else {
                // 로그인 성공
                print("로그인 성공: \(authResult?.user.email ?? "")")
                self?.goToMainTab(index: 2)
            }
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
