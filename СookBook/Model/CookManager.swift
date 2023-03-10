//
//  CookManager.swift
//  СookBook
//
//  Created by Vladimir V. on 28.02.2023.
//

import Foundation
import CoreLocation

enum TypeRequestURL {
    case popularRecipe
    case recipe
    case search
    case typePopularRecpe
    case image
}

protocol CookManagerDelegate {
    func didUpdateRecipe(_ cookManager: CookManager, recipeInfoData: RecipeInfoData)
    func didUpdatePopularRecipesData(_ cookManager: CookManager, recipes: [RecipeData])
    func didUpdateSearchRecipesData(_ cookManager: CookManager, recipes: [RecipeData])
    func didUpdateTypePopularRecipesData(_ cookManager: CookManager, recipes: [RecipeData], typeMeal: TypeMeal)
    func didLoadImage(_ cookManager: CookManager, recipeId: Int, data: Data)
    func didFailWithError(error: Error)
}

final class CookManager {
    var cookData =  CookModel()
    var delegate: CookManagerDelegate?

    // Access Shared Defaults Object
    private let userDefaults = UserDefaults.standard

    init() {
        cookData.favoriteRecipes = (userDefaults.object(forKey: "favoriteRecipes") as? [Int]) ?? []
        for recipeId in cookData.favoriteRecipes {
            if !cookData.recipeDict.keys.contains(recipeId){
                fetchRecipe(recipeId: recipeId)
            }
        }
        cookData.historyRecipes = (userDefaults.object(forKey: "historyRecipes") as? [Int]) ?? []
        for recipeId in cookData.historyRecipes {
            if !cookData.recipeDict.keys.contains(recipeId){
                fetchRecipe(recipeId: recipeId)
            }
        }
    }

    func fetchRecipe(recipeId: Int) {
        performRequest(with: .recipe, searchText: "\(recipeId)")
    }
    
    func fetchRecipeImage(recipeId: Int) {
        performRequest(with: .image, searchText: "\(recipeId)")
    }
    
    func fetchPopularRecipe() {
        performRequest(with: .popularRecipe)
    }
    
    func fetchSearchRecipe(text: String) {
        performRequest(with: .search, searchText: text)
    }
    
    func fetchTypePopularRecipe(type: TypeMeal) {
        performRequest(with: .typePopularRecpe, searchText: type.rawValue.replacingOccurrences(of: " ", with: "%20"), typeMeal: type)
    }
    
    func performRequest(with type: TypeRequestURL, searchText: String = "", typeMeal: TypeMeal? = nil) {
        let strType = getRequestURL(with: type)
        let urlString = String(format: strType, searchText)
//        print("URL: \(urlString)")
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    switch type {
                    case .popularRecipe:
                        if let recipe = self.parseArrayJSON(safeData) {
                            self.delegate?.didUpdatePopularRecipesData(self, recipes: recipe)
                        }
                    case .recipe:
                        if let recipeInfoData = self.parseRecipeJSON(safeData) {
                            DispatchQueue.main.async {
                                if !self.cookData.recipeDict.keys.contains(recipeInfoData.id) {
                                    self.cookData.recipeDict[recipeInfoData.id] = recipeInfoData
                                    if self.cookData.favoriteRecipes.contains(recipeInfoData.id) {
                                        self.cookData.recipeDict[recipeInfoData.id]!.favorite = true
                                    }
                                    
                                }
                                
                                self.delegate?.didUpdateRecipe(self, recipeInfoData: recipeInfoData)
                            }
                        }
                    case .search:
                        if let recipe = self.parseArrayJSON(safeData) {
                            self.delegate?.didUpdateSearchRecipesData(self, recipes: recipe)
                        }
                    case .typePopularRecpe:
                        if let recipe = self.parseArrayJSON(safeData) {
                            DispatchQueue.main.async {
                                self.delegate?.didUpdateTypePopularRecipesData(self, recipes: recipe, typeMeal: typeMeal!)
                            }
                        }
                    case .image:
                        DispatchQueue.main.async {
                            self.delegate?.didLoadImage(self, recipeId: Int(searchText)!, data: safeData)
                        }
                    }
                    
                }
            }
            task.resume()
        }
    }
    
    func parseArrayJSON(_ cookData: Data) -> [RecipeData]? {
        let decoder = JSONDecoder()
        do {
            let recipe = try decoder.decode(PopularRecipesData.self, from: cookData)
            return recipe.arrayRecipe
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func parseRecipeJSON(_ cookData: Data) -> RecipeInfoData? {
        let decoder = JSONDecoder()
        do {
            let recipe = try decoder.decode(RecipeInfoData.self, from: cookData)
            return recipe
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    private func getRequestURL(with type: TypeRequestURL) -> String {
        switch type {
        case .popularRecipe:
            return "http://135.181.99.110:8080/recipes/complexSearch?sort=popularity&apiKey=your_key"
        case .search:
            return "http://135.181.99.110:8080/recipes/complexSearch?sort=popularity&query=%@&apiKey=your_key"
        case .recipe:
            return "http://135.181.99.110:8080/recipes/%@/information?apiKey=your_key"
        case .typePopularRecpe:
            return "http://135.181.99.110:8080/recipes/complexSearch?sort=popularity&type=%@&apiKey=your_key"
        case .image:
            return "https://spoonacular.com/recipeImages/%@-312x231.jpg"
        }
    }
    func checkFavoriteRecipe(recipe: RecipeInfoData) {
        _ = cookData.addOrRemoveFavoriteRecipe(recipe)
        userDefaults.set(cookData.favoriteRecipes, forKey: "favoriteRecipes")
    }
    
    func addHistoriRecipe(recipe: RecipeInfoData) {
        
        if let index = cookData.historyRecipes.firstIndex(of: recipe.id) {
            cookData.historyRecipes.remove(at: index)
            
        }
        cookData.historyRecipes.insert(recipe.id, at: 0)
        if cookData.historyRecipes.count > 10 {
            cookData.historyRecipes.remove(at: 10)
        }
        userDefaults.set(cookData.historyRecipes, forKey: "historyRecipes")
    }
    
}
