//
//  Alert.swift
//  manageRefrigerator
//
//  Created by suki on 6/10/25.
//
import UIKit

extension UIViewController {
    
    // 기본 알림 (확인 버튼만)
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
    
    // 완료 콜백이 있는 알림
    func showAlert(title: String, message: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
            completion()
        })
        present(alert, animated: true)
    }
    
    // 확인/취소 버튼이 있는 알림
    func showConfirmAlert(title: String, message: String, confirmHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
            confirmHandler()
        })
        present(alert, animated: true)
    }
}
