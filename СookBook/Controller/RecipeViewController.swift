//
//  RecipeViewController.swift
//  СookBook
//
//  Created by Лилия Феодотова on 26.02.2023.
//

import UIKit

final class RecipeViewController: UIViewController, RecipeViewDelegate, Coordinating {
    
    var coordinator: Coordinator?
    var recipe: RecipeData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        view.addLabelText((self.tabBarItem.title ?? "RecipeViewController"))
        
        let viewCell =  RecipeView()
        viewCell.recipeViewDelegate = self
        viewCell.reloadRecipe(recipe: recipe!)
        viewCell.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewCell)
        NSLayoutConstraint.activate([
                viewCell.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
                viewCell.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
                viewCell.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 5),
                viewCell.heightAnchor.constraint(equalTo: view.widthAnchor, constant: 5),
        ])
    }
    func didUpdateView() {
        print("didUpdateView")
    }
    
    func pushCheckFavorite(recipe: RecipeData) {
        coordinator?.eventOccurred(with: .favoriteTapped, recipe: recipe)
    }
}
