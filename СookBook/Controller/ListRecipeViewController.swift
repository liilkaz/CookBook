//
//  ListRecipeViewController.swift
//  СookBook
//
//  Created by Vladimir V. on 28.02.2023.
//

import SwiftUI

final class ListRecipeViewController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow

        let recipe =  RecipeView()
        recipe.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recipe)
        
        NSLayoutConstraint.activate([
            recipe.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 10),
            recipe.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            recipe.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            recipe.heightAnchor.constraint(equalTo: recipe.widthAnchor ),
                 ])
    }
    
    @objc func pushRecipeImage() {
        
    }
    func didUpdateView() {
        
    }
}
