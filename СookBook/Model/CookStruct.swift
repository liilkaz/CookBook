//
//  CookStruct.swift
//  СookBook
//
//  Created by Vladimir V. on 01.03.2023.
//

import Foundation


struct RecipeData: Codable {
    let id: Int
    let title: String
    let image: String
    let imageType: String
}
struct RecipeInfoData: Codable {
    let id: Int
    let nameClean: String
    let amount: Int
}

extension RecipeData {
      init(from decoder: Decoder) throws {
          let values = try decoder.container(keyedBy: CodingKeys.self)
          id = try values.decode(Int.self, forKey: .id)
          title = try values.decode(String.self, forKey: .title)
          image = try values.decode(String.self, forKey: .image)
          imageType = try values.decode(String.self, forKey: .imageType)
      }
}
extension RecipeInfoData {
      init(from decoder: Decoder) throws {
          let values = try decoder.container(keyedBy: CodingKeys.self)
          id = try values.decode(Int.self, forKey: .id)
          nameClean = try values.decode(String.self, forKey: .nameClean)
          amount = try values.decode(Int.self, forKey: .amount)
          
      }
}

struct PopularRecipesData: Codable {
    let arrayRecipe: [RecipeData]
    
    enum CodingKeys: String, CodingKey {
        case arrayRecipe = "results"
    }
}
struct RecipeIngridientsInfo: Codable{
    let extendedIngredients: [RecipeInfoData]
    let idOfRecipe: Int
}

extension PopularRecipesData {
      init(from decoder: Decoder) throws {
          let values = try decoder.container(keyedBy: CodingKeys.self)
          arrayRecipe = try values.decode([RecipeData].self, forKey: .arrayRecipe)
      }
}
extension RecipeIngridientsInfo{
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        extendedIngredients = try values.decode([RecipeInfoData].self, forKey: .extendedIngredients)
        idOfRecipe = try values.decode(Int.self, forKey: .idOfRecipe)

    }
}
