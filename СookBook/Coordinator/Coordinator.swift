//
//  Coordinator.swift
//  СookBook
//
//  Created by Vladimir V. on 28.02.2023.
//

import Foundation
import UIKit

enum Event {
    case startTapped
    case recipeTapped
    case listRecipeTapped
    case favoriteTapped
}

enum TypeViewController {
    case launchScreenVC
    case recipeVC
    case homeVC
    case categoriesVC
    case searchVC
    case favoriteVC
}

protocol Coordinator {
    var navigationController: UINavigationController? {get set}
    var children : [Coordinator]? {get set}
    var cookManager: CookManager? {get set}
    var activeViewController: [UIViewController]? {get set}
    var imagesDictionary: Dictionary<Int, UIImage> {get}
    
    func start()
    func eventOccurred(with type: Event, recipe: RecipeInfoData, typeMeal:TypeMeal)
    
    func addController(type: TypeViewController, controller: Coordinating)
    func getImage(_ recipeId: Int) -> UIImage
    func getRecipe(_ recipeId: Int) -> RecipeInfoData
}

protocol Coordinating {
    var coordinator: Coordinator? {get set}
    func didUpdateView()
    func didUpdateImage(recipeId: Int)
}

extension Coordinator {
    func eventOccurred(with type: Event, typeMaal: TypeMeal) {
        eventOccurred(with: type, recipe: RecipeInfoData(from: RecipeData(id: 1, title: "", image: "", imageType: "")), typeMeal: typeMaal)
    }
    func eventOccurred(with type: Event, recipe: RecipeInfoData) {
        eventOccurred(with: type, recipe: recipe, typeMeal: TypeMeal.none)
    }
    func eventOccurred(with type: Event) {
        eventOccurred(with: type, recipe: RecipeInfoData(from: RecipeData(id: 1, title: "", image: "", imageType: "")), typeMeal: TypeMeal.none)
    }
}
