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
}

protocol CookManagerDelegate {
    func didUpdateRecipe(_ cookManager: CookManager, recipe: RecipeData)
    func didUpdatePopularRecipesData(_ cookManager: CookManager, recipes: [RecipeData])
    func didFailWithError(error: Error)
}

final class CookManager {
    var cookData =  CookModel()
    var delegate: CookManagerDelegate?
    
    func fetchRecipe(recipeId: Int) {

    }
    
    func fetchPopularRecipe() {
        performRequest(with: .popularRecipe)
    }
    
    func performRequest(with type: TypeRequestURL) {
        if let url = URL(string: getRequestURL(with: type)) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    switch type {
                    case .popularRecipe:
                        if let recipe = self.parsePopularJSON(safeData) {
                            self.delegate?.didUpdatePopularRecipesData(self, recipes: recipe)
                        }
                    case .recipe:
                        if let recipe = self.parseRecipeJSON(safeData) {
                            self.delegate?.didUpdateRecipe(self, recipe: recipe)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parsePopularJSON(_ cookData: Data) -> [RecipeData]? {
        let decoder = JSONDecoder()
        do {
            let recipe = try decoder.decode(PopularRecipesData.self, from: cookData)
            return recipe.arrayRecipe
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func parseRecipeJSON(_ cookData: Data) -> RecipeData? {
        let decoder = JSONDecoder()
        do {
            let recipe = try decoder.decode(RecipeData.self, from: cookData)
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
        case .recipe:
            return "http://135.181.99.110:8080/recipes/715449/information?apiKey=your_key"
        }
    }
    
}
