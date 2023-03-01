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
}
