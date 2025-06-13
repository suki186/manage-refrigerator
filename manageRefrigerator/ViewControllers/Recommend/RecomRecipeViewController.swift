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
    let row: [RecipeRow]?
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

class RecomRecipeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
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

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        searchTextField.delegate = self

        collectionView.register(
            UINib(nibName: "RecRecipeCardCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "RecRecipeCardCell"
        )
        
        fetchRecipesFromAPI()

    }
    
    // 엔터 입력 시 검색
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let keyword = textField.text ?? ""
        fetchRecipesFromAPI(keyword: keyword) // 빈 값이면 전체 호출
        textField.text = "" // 입력 초기화
        
        return true
    }
    
    // 돋보기버튼 클릭 시 검색
    @IBAction func searchButtonTapped(_ sender: Any) {
        let keyword = searchTextField.text ?? ""
        fetchRecipesFromAPI(keyword: keyword)
        searchTextField.resignFirstResponder()
        searchTextField.text = ""
    }
    
    
    // 공공데이터 api 호출 함수
    func fetchRecipesFromAPI(keyword: String = "") {
        let baseURL = "http://openapi.foodsafetykorea.go.kr/api/eb3cacd4a8154adda95d/COOKRCP01/json/1/10"
        var urlString = baseURL
        
        if !keyword.isEmpty {
            let encoded = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            urlString += "/RCP_NM=\(encoded)"
        }
        
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
                    let newRecipes = apiResponse.COOKRCP01.row?.map { Recipe(from: $0) } ?? []
                    DispatchQueue.main.async {
                        self?.recipes = newRecipes
                        self?.collectionView.reloadData()
                        
                        if newRecipes.isEmpty {
                            self?.showAlert(title: "검색 결과 없음", message: "입력한 키워드에 해당하는 레시피가 없습니다.") {
                                self?.fetchRecipesFromAPI()
                            }
                        }
                    }
                } else {
                    // INFO-200 같은 결과 없음 코드
                    DispatchQueue.main.async {
                        self?.recipes = []
                        self?.collectionView.reloadData()
                        self?.showAlert(title: "검색 결과 없음", message: "입력한 키워드에 해당하는 레시피가 없습니다.") {
                            self?.fetchRecipesFromAPI()
                        }
                    }
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
    
    @IBAction func searchRecipe(_ sender: UITextField) {
        if let keyword = searchTextField.text, !keyword.isEmpty {
            fetchRecipesFromAPI(keyword: keyword)
            searchTextField.resignFirstResponder()
        }
    }
    
    

}
