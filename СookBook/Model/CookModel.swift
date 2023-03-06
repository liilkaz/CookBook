//
//  CookModel.swift
//  СookBook
//
//  Created by Vladimir V. on 01.03.2023.
//

import Foundation

enum TypeMeal: String  {
    case none
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
    var recipeDict = Dictionary<Int, RecipeInfoData>()
    var typeMealDict = Dictionary<TypeMeal, [Int]>()
    var typeTopMealItem = Dictionary<TypeMeal, Int>()
    var popularRecipes:[Int] = []
    var favoriteRecipes:[Int] = []
    var searchRecipes:[Int] = []
    var lastActiveRecipes:[Int] = []
    
    // true - was added & false - was removed
    mutating func addOrRemoveFavoriteRecipe(_ recipe: RecipeInfoData)-> Bool {
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
                self.recipeDict[item.id] = RecipeInfoData(from: item)
            }
            
            self.searchRecipes.append(item.id)
        }
    }
    mutating func setPopularRecipes(array: [RecipeData]) {
        popularRecipes = []
        for item in array {
            if !self.recipeDict.keys.contains(item.id) {
                self.recipeDict[item.id] = RecipeInfoData(from: item)
            }
            
            self.popularRecipes.append(item.id)
        }
    }
    mutating func setFavoriteRecipes(array: [RecipeData]) {
        favoriteRecipes = []
        for item in array {
            if !self.recipeDict.keys.contains(item.id) {
                self.recipeDict[item.id] = RecipeInfoData(from: item)
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
        self.typeTopMealItem[typeMeal] = array[0].id
        for item in array {
            if !self.recipeDict.keys.contains(item.id) {
                self.recipeDict[item.id] = RecipeInfoData(from: item)
            }
            if !typeMealDict.keys.contains(typeMeal) { //toDo thread
                self.typeMealDict[typeMeal] = []
                
            }
            self.typeMealDict[typeMeal]!.append(item.id)
        }
    }
    func topMealItems() -> [(TypeMeal, Int)] {
        var items: [(TypeMeal, Int)] = []
        for typeMeal in TypeMeal.allCases {
            if !self.typeTopMealItem.keys.contains(typeMeal) {
                assertionFailure("There was an issue  adding viewController in MainCoordinator")
            }
            items.append( (typeMeal, typeTopMealItem[typeMeal]!) )
        }
        return items
    }
    
    func isFavoriteRecipe(recipeId: Int) -> Bool {
        return favoriteRecipes.contains(recipeId)
    }
}
