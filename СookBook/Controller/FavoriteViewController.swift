//
//  FavoriteViewController.swift
//  СookBook
//
//  Created by Vladimir V. on 28.02.2023.
//

import UIKit

final class FavoriteViewController: UIViewController, RecipeViewDelegate, Coordinating {
    
    var coordinator: Coordinator?
    var tableViewController = UITableViewController(style: .plain)
    var cellIndentifier = "Cell"
    var arrayItems:[RecipeData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        tableViewController.tableView.backgroundColor = .clear
        createTable()
        view.addSubview(tableViewController.tableView)
        tableViewController.tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableViewController.tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableViewController.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableViewController.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableViewController.tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
        arrayItems = (coordinator?.cookManager?.cookData.favoriteRecipes)!
    }

    func createTable() {
        tableViewController.tableView.separatorColor = UIColor.green
        tableViewController.tableView.frame = view.bounds
        tableViewController.tableView.rowHeight = 100
        tableViewController.tableView.register(RecipeViewCell.self, forCellReuseIdentifier: cellIndentifier)
        tableViewController.tableView.delegate = self
        tableViewController.tableView.dataSource = self
    }
    
    @objc func pushRecipeImage() {
        coordinator?.eventOccurred(with: .recipeTapped)
    }
    
    @objc func didTapButton() {
        //coordinator?.eventOccurred(with: .buttonTapped)
    }
    func didUpdateView() {
        arrayItems = (coordinator?.cookManager?.cookData.favoriteRecipes)!
        DispatchQueue.main.async {
            self.tableViewController.tableView.reloadData()
        }
    }
    func pushCheckFavorite(recipe: RecipeData) {
        coordinator?.eventOccurred(with: .favoriteTapped, recipe: recipe)
    }
}


extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier, for: indexPath) as? RecipeViewCell {
            cell.viewCell?.recipeViewDelegate = self
            cell.refresh(arrayItems[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // _ = tableView.dequeueReusableCell(withIdentifier: cellIndentifier, for: indexPath)
        coordinator?.eventOccurred(with: .recipeTapped, recipe: arrayItems[indexPath.row])
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


extension FavoriteViewController {
    func didUpdateRecipe(recipe: RecipeData) {
        print("didUpdateRecipe")
    }
    
    func didUpdateTableData() {
        print("didUpdateTableData")
        arrayItems = (coordinator?.cookManager?.cookData.favoriteRecipes)!
        DispatchQueue.main.async {
            self.tableViewController.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print("didFailWithError")
    }
}


