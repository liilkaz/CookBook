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
}

protocol Coordinator {
    var navigationController: UINavigationController? {get set}
    var children : [Coordinator]? {get set}
    var cookManager: CookManager? {get set}
    var activeViewController: UIViewController? {get set}
    
    func start()
    func eventOccurred(with type: Event, recipe: RecipeData)
}

protocol Coordinating {
    var coordinator: Coordinator? {get set}
    func didUpdateView()
}

extension Coordinator {
    func eventOccurred(with type: Event) {
        eventOccurred(with: type, recipe: RecipeData(id: 1, title: "", image: "", imageType: ""))
    }
}
