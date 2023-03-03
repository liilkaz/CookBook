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
}

protocol CookManagerDelegate {
    func didUpdateRecipe(_ cookManager: CookManager, recipe: RecipeInfoData)
    func didUpdatePopularRecipesData(_ cookManager: CookManager, recipes: [RecipeData])
    func didUpdateSearchRecipesData(_ cookManager: CookManager, recipes: [RecipeData])
    func didFailWithError(error: Error)
}

final class CookManager {
    var cookData =  CookModel()
    var delegate: CookManagerDelegate?
    
    func fetchRecipe(recipeId: Int) {
        performRequest(with: .recipe)
    }
    
    func fetchPopularRecipe() {
        performRequest(with: .popularRecipe)
    }
    
    func fetchSearchRecipe(text: String) {
        performRequest(with: .search, searchText: text)
    }
    
    func performRequest(with type: TypeRequestURL, searchText: String = "") {
        let strType = getRequestURL(with: type)
        let urlString = String(format: strType, searchText)
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
                        if let recipe = self.parseRecipeJSON(safeData) {
                            self.delegate?.didUpdateRecipe(self, recipe: recipe)
                        }
                    case .search:
                        if let recipe = self.parseArrayJSON(safeData) {
                            self.delegate?.didUpdateSearchRecipesData(self, recipes: recipe)
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
            return "http://135.181.99.110:8080/recipes/715449/information?apiKey=your_key"
        }
    }
    func checkFavoriteRecipe(recipe: RecipeData) {
        _ = cookData.addOrRemoveFavoriteRecipe(recipe)
    }
    
}
