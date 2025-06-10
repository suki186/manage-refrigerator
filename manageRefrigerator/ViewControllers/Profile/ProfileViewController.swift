//
//  ProfileViewController.swift
//  manageRefrigerator
//
//  Created by suki on 6/1/25.
//

import UIKit
import FirebaseAuth

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
        
        loadUserEmail()

    }
    
    // 현재 로그인된 사용자의 이메일 표시
    private func loadUserEmail() {
        if let currentUser = Auth.auth().currentUser {
            IdLabel.text = currentUser.email
        } else {
            IdLabel.text = "로그인이 필요합니다"
        }
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        do {
           try Auth.auth().signOut()
           
           // 로그인 페이지로 이동
           if let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
               loginVC.modalPresentationStyle = .fullScreen
               present(loginVC, animated: true, completion: nil)
           }
           
       } catch let signOutError as NSError {
           print("Error signing out: %@", signOutError)
           
           // 에러 알림 표시
           let alert = UIAlertController(title: "로그아웃 실패",
                                       message: "로그아웃 중 오류가 발생했습니다.",
                                       preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "확인", style: .default))
           present(alert, animated: true)
       }
    }
    

}
