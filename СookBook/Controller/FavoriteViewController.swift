//
//  FavoriteViewController.swift
//  СookBook
//
//  Created by Vladimir V. on 28.02.2023.
//

import UIKit

final class FavoriteViewController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    var recipeTableView: RecipeTableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        recipeTableView = RecipeTableView()
        view.addSubview(recipeTableView!)
        recipeTableView!.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            recipeTableView!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            recipeTableView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recipeTableView!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recipeTableView!.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
        recipeTableView?.arrayItems = (coordinator?.cookManager?.cookData.favoriteRecipes)!
        recipeTableView?.coordinator = coordinator
    }
    
    func didUpdateView() {
        recipeTableView?.arrayItems = (coordinator?.cookManager?.cookData.favoriteRecipes)!
        DispatchQueue.main.async {
            self.recipeTableView?.tableViewController.tableView.reloadData()
        }
    }
    func didUpdateImage(imageString: String) {
       // <#code#>
    }
}

extension UIView {
    func addLabelText(_ text: String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 220, height: 55))
        self.addSubview(label)
        label.center = self.center
        label.text = text
        label.textColor = .black
    }
}

