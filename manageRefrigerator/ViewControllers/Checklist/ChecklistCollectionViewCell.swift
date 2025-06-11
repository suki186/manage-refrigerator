//
//  ChecklistCollectionViewCell.swift
//  manageRefrigerator
//
//  Created by suki on 6/4/25.
//

import UIKit

class ChecklistCollectionViewCell: UICollectionViewCell, UITextFieldDelegate {

    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var checkText: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    
    var checkButtonTapped: (() -> Void)?
    var textFieldEdited: ((String) -> Void)?
    var onEnterPressed: ((String) -> Void)?
    var deleteButtonTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        checkText.borderStyle = .none
        checkText.placeholder = "뭘 살까?"
        
        checkButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        checkButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        if #available(iOS 15.0, *) {
            checkButton.configuration = .plain()
            checkButton.configurationUpdateHandler = { button in
                var config = button.configuration
                config?.background.backgroundColor = .clear // 강조 효과 제거
                button.configuration = config
            }
        } else {
            // iOS 14 이하
            checkButton.adjustsImageWhenHighlighted = false
        }
        
        checkButton.addTarget(self, action: #selector(checkButtonAction), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)

        checkText.delegate = self
        checkText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @IBAction func checkButtonAction(_ sender: UIButton) {
        checkButtonTapped?()
    }
    
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        deleteButtonTapped?()
    }
    
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        textFieldEdited?(sender.text ?? "")
    }
    
    // 엔터 누를 때
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        onEnterPressed?(textField.text ?? "")
        return true
    }
    
    // focus 함수
    func focusTextField() {
        checkText.becomeFirstResponder()
    }
    
}
