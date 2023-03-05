//
//  CookModel.swift
//  СookBook
//
//  Created by Vladimir V. on 01.03.2023.
//

import Foundation

enum TypeMeal: String  {
    case mainCourse = "main%20course"
    case sideDish = "side%20dish"
    case dessert = "dessert"
    case appetizer = "appetizer"
    case salad = "salad"
    case bread = "bread"
    case breakfast = "breakfast"
    case soup = "soup"
    case beverage = "beverage"
    case sauce = "sauce"
    case marinade = "marinade"
    case fingerfood = "fingerfood"
    case snack = "snack"
    case drink = "drink"
    
    static var allCases: [TypeMeal] {
        return [.mainCourse, .sideDish, .dessert, .appetizer, .salad, .bread, .breakfast, .soup, .beverage, .sauce, .marinade, .fingerfood, .snack, .drink]
    }
}

struct CookModel {
    let id: Int = 9
    var recipeDict = Dictionary<Int, RecipeData>()
    var typeMealDict = Dictionary<TypeMeal, [Int]>()
    var typeTopMealItem = Dictionary<TypeMeal, (String, String)>()
    var popularRecipes:[Int] = []
    var favoriteRecipes:[Int] = []
    var searchRecipes:[Int] = []
    var lastActiveRecipes:[Int] = []

    // true - was added & false - was removed
    mutating func addOrRemoveFavoriteRecipe(_ recipe: RecipeData)-> Bool {
        if let index = favoriteRecipes.firstIndex(of: recipe.id) {
            favoriteRecipes.remove(at: index)
            recipeDict[recipe.id]?.favorite = false
        } else {
            favoriteRecipes.insert(recipe.id, at: 0)
            recipeDict[recipe.id]?.favorite = true
        }
        return recipeDict[recipe.id]!.favorite
    }
    
    mutating func setSearchRecipe(array: [RecipeData]) {
        searchRecipes = []
        for item in array {
            if !self.recipeDict.keys.contains(item.id) {
                self.recipeDict[item.id] = item
            }
            
            self.searchRecipes.append(item.id)
        }
    }
    mutating func setPopularRecipes(array: [RecipeData]) {
        popularRecipes = []
        for item in array {
            if !self.recipeDict.keys.contains(item.id) {
                self.recipeDict[item.id] = item
            }
            
            self.popularRecipes.append(item.id)
        }
    }
    mutating func setFavoriteRecipes(array: [RecipeData]) {
        favoriteRecipes = []
        for item in array {
            if !self.recipeDict.keys.contains(item.id) {
                self.recipeDict[item.id] = item
            }
            self.recipeDict[item.id]?.favorite = true
            self.favoriteRecipes.append(item.id)
        }
    }
    mutating func setTypeMealRecipes(typeMeal: TypeMeal, array: [RecipeData]) {
        
        popularRecipes = []
        if array.isEmpty {
            return
        }
        print("\(typeMeal.rawValue) Image \(array[0].image)")
        self.typeTopMealItem[typeMeal] = (typeMeal.rawValue, array[0].image)
        for item in array {
            if !self.recipeDict.keys.contains(item.id) {
                self.recipeDict[item.id] = item
            }
            if !typeMealDict.keys.contains(typeMeal) { //toDo thread
                self.typeMealDict[typeMeal] = []
                
            }
            self.typeMealDict[typeMeal]!.append(item.id)
        }
    }
    func topMealItems() -> [(String, String)] {
        var items: [(String, String)] = []
        for typeMeal in TypeMeal.allCases {
            if !self.typeTopMealItem.keys.contains(typeMeal) {
                assertionFailure("There was an issue  adding viewController in MainCoordinator")
            }
            items.append(((typeTopMealItem[typeMeal]))!)
        }
        return items
    }
}
