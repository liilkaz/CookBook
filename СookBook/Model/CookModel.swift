//
//  CookModel.swift
//  СookBook
//
//  Created by Vladimir V. on 01.03.2023.
//

import Foundation


struct CookModel {
    let id: Int = 9
    var popularRecipes:[RecipeData] = []
    var favoriteRecipes:[RecipeData] = []
    var lastActiveRecipes:[RecipeData] = []
    
    // true - was added & false - was removed
    mutating func addOrRemoveFavoriteRecipe(_ recipe: RecipeData)-> Bool {
        var index = 0
        for item in favoriteRecipes {
            if item.id == recipe.id {
                break
            }
            index+=1
        }
        if index == favoriteRecipes.count {
            self.favoriteRecipes.insert(recipe, at: 0)
            return true
        }
        self.favoriteRecipes.remove(at: index)
        return false

    }
}
