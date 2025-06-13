//
//  RecRecipeDetailViewController.swift
//  manageRefrigerator
//
//  Created by suki on 6/13/25.
//

import UIKit

class RecRecipeDetailViewController: UIViewController {
    var recipe: RecipeRow? // 받은 데이터
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var calorieLabel: UILabel!
    @IBOutlet weak var ingredientLabel: UITextView!
    @IBOutlet weak var stepsLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    

    private func configureUI() {
        guard let recipe = recipe else { return }

        titleLabel.text = recipe.RCP_NM
        calorieLabel.text = "열량: \(recipe.INFO_ENG) kcal"
        ingredientLabel.text = recipe.RCP_PARTS_DTLS

        if let url = URL(string: recipe.ATT_FILE_NO_MAIN) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                        self.imageView.contentMode = .scaleAspectFill
                        self.imageView.clipsToBounds = true
                    }
                }
            }
        }

        // Dictionary로 변환 후 만드는 법 추출
        let dict = recipe.toDictionary()
        var stepsText = ""
        for i in 1...20 {
            let key = String(format: "MANUAL%02d", i)
            if let step = dict[key], !step.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                stepsText += "\(i). \(step.trimmingCharacters(in: .whitespaces))\n\n"
            }
        }

        stepsLabel.text = stepsText.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
