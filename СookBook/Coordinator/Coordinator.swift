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
    var activeViewController: UIViewController? {get set}
    var imagesDictionary: Dictionary<String, UIImage> {get}
    
    func start()
    func eventOccurred(with type: Event, recipe: RecipeData)
    func addController(type: TypeViewController, controller: Coordinating)
    func getImage(_ urlString: String) -> UIImage
}

protocol Coordinating {
    var coordinator: Coordinator? {get set}
    func didUpdateView()
    func didUpdateImage(imageString: String)
}

extension Coordinator {
    func eventOccurred(with type: Event) {
        eventOccurred(with: type, recipe: RecipeData(id: 1, title: "", image: "", imageType: ""))
    }
}
