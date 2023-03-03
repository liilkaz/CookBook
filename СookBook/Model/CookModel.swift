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
    var searchRecipes:[RecipeData] = []
    var lastActiveRecipes:[RecipeData] = []
    
    let meealTypeArray = ["main course",
                          "side dish",
                          "dessert",
                          "appetizer",
                          "salad",
                          "bread",
                          "breakfast",
                          "soup",
                          "beverage",
                          "sauce",
                          "marinade",
                          "fingerfood",
                          "snack",
                          "drink"]
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
