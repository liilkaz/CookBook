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

extension RecipeData {
      init(from decoder: Decoder) throws {
          let values = try decoder.container(keyedBy: CodingKeys.self)
          id = try values.decode(Int.self, forKey: .id)
          title = try values.decode(String.self, forKey: .title)
          image = try values.decode(String.self, forKey: .image)
          imageType = try values.decode(String.self, forKey: .imageType)
      }
}

struct RecipeInfoData: Codable {
    let id: Int
    let title: String
    let extendedIngredients: [RecipeIngridientsInfo]
    
}
extension RecipeInfoData{
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        extendedIngredients = try values.decode([RecipeIngridientsInfo].self, forKey: .extendedIngredients)
    }
}

struct RecipeIngridientsInfo: Codable{
    //let extendedIngredients: [RecipeInfoData]
    let id: Int
    let amount: Double
    let unit: String
    let meta: [String]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        //extendedIngredients = try values.decode([RecipeInfoData].self, forKey: .extendedIngredients)
        id = try values.decode(Int.self, forKey: .id)
        amount = try values.decode(Double.self, forKey: .amount)
        unit = try values.decode(String.self, forKey: .unit)
        meta = try values.decode([String].self, forKey: .meta)
    }
}
struct PopularRecipesData: Codable {
    let arrayRecipe: [RecipeData]
    
    enum CodingKeys: String, CodingKey {
        case arrayRecipe = "results"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        arrayRecipe = try values.decode([RecipeData].self, forKey: .arrayRecipe)
    }
}
