//
//  SignupViewController.swift
//  manageRefrigerator
//
//  Created by suki on 6/6/25.
//

import UIKit
import FirebaseAuth

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
    

    @IBAction func signUpTapped(_ sender: UIButton) {
        let email = idTextField.text ?? ""
        let password = pwTextField.text ?? ""
        let repeatPassword = rpwTextField.text ?? ""
        
        // 입력 검증
        guard !email.isEmpty, !password.isEmpty, !repeatPassword.isEmpty else {
            showAlert(title: "입력 오류", message: "모든 필드를 입력해주세요.") {
            }
            return
        }
        
        guard password == repeatPassword else {
            showAlert(title: "비밀번호 오류", message: "비밀번호가 일치하지 않습니다.") {
            }
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("회원가입 실패: \(error.localizedDescription)")
            } else {
                print("회원가입 성공: \(authResult?.user.email ?? "")")
                self.showAlert(title: "환영합니다", message: "FRISH와 함께 깨끗한 냉장고를 만들어보세요!") {
                    // 회원가입 성공 후 로그인 페이지로 돌아가기
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    func showAlert(title: String, message: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
            completion()
        })
        self.present(alert, animated: true, completion: nil)
    }
    

}
