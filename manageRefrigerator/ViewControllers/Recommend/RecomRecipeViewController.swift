//
//  RecomRecipeViewController.swift
//  manageRefrigerator
//
//  Created by suki on 6/4/25.
//

import UIKit

struct APIResponse: Codable {
    let COOKRCP01: CookRecipe
}

struct CookRecipe: Codable {
    let total_count: String
    let row: [RecipeRow]
    let RESULT: APIResult
}

struct RecipeRow: Codable {
    let RCP_NM: String // 메뉴명
    let ATT_FILE_NO_MAIN: String // 이미지경로(소)
}

struct APIResult: Codable {
    let MSG: String
    let CODE: String
}

struct Recipe {
    let title: String
    let imageUrl: String
    
    // API 데이터 생성자
    init(from recipeRow: RecipeRow) {
        self.title = recipeRow.RCP_NM
        self.imageUrl = recipeRow.ATT_FILE_NO_MAIN
    }
}

class RecomRecipeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var recipes: [Recipe] = [] // 추천 레시피 목록
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecRecipeCardCell", for: indexPath) as? RecRecipeCardCollectionViewCell else {
                return UICollectionViewCell()
            }
            let recipe = recipes[indexPath.item]
            cell.configure(with: recipe)
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 165, height: 140)  // 셀 크기
    }

    
    @IBOutlet weak var MyRecipeButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        MyRecipeButton.layer.shadowColor = UIColor.black.cgColor
        MyRecipeButton.layer.shadowOpacity = 0.2
        MyRecipeButton.layer.shadowOffset = CGSize(width: 0, height: -2)
        MyRecipeButton.layer.shadowRadius = 10
        MyRecipeButton.layer.masksToBounds = false
        
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(
            UINib(nibName: "RecRecipeCardCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "RecRecipeCardCell"
        )
        
        fetchRecipesFromAPI()

    }
    
    // 공공데이터 api 호출 함수
    func fetchRecipesFromAPI() {
        let urlString = "http://openapi.foodsafetykorea.go.kr/api/eb3cacd4a8154adda95d/COOKRCP01/json/1/5"
        
        guard let url = URL(string: urlString) else {
            print("잘못된 URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("네트워크 에러: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("데이터가 없습니다.")
                return
            }

            do {
                // JSON -> APIResponse 구조체
                let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                
                if apiResponse.COOKRCP01.RESULT.CODE == "INFO-000" {
                    let newRecipes = apiResponse.COOKRCP01.row.map { Recipe(from: $0) }
                    
                    DispatchQueue.main.async {
                        self?.recipes = newRecipes
                        self?.collectionView.reloadData()
                        print("\(newRecipes.count)개 레시피 로드 성공")
                    }
                } else {
                    print("API 에러: \(apiResponse.COOKRCP01.RESULT.MSG)")
                }
                
            } catch {
                print("JSON 파싱 에러: \(error)")
                
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("JSON 데이터:\n\(jsonString)")
                }
            }
        }
        task.resume()
    }
    

}
