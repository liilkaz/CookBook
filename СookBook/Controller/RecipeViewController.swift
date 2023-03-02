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
    var viewCell = RecipeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        view.addLabelText((self.tabBarItem.title ?? "RecipeViewController"))
        
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
        viewCell.updateImage(image: (coordinator?.getImage(recipe!.image))! )
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewCell.updateImage(image: (coordinator?.getImage(recipe!.image))! )
    }
    func didUpdateView() {
        viewCell.updateImage(image: (coordinator?.getImage(recipe!.image))! )
    }
    
    func didUpdateImage(imageString: String) {
        print(imageString)
        viewCell.updateImage(image: (coordinator?.getImage(imageString))! )
    }
    
    
    func pushCheckFavorite(recipe: RecipeData) {
        coordinator?.eventOccurred(with: .favoriteTapped, recipe: recipe)
    }
}
