//
//  RecipeTableView.swift
//  СookBook
//
//  Created by Vladimir V. on 02.03.2023.
//

import UIKit

final class RecipeTableView: UIView {
    var coordinator: Coordinator?
    let cellSpacingHeight: CGFloat = 10
    var tableViewController = UITableViewController(style: .plain)
    var cellIndentifier = "Cell"
    var arrayItems:[Int] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        self.addSubview(tableViewController.tableView)
        createTable()
    }
    
    func setConstrains() {
        tableViewController.tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableViewController.tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableViewController.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            tableViewController.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            tableViewController.tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
    }
    
    func createTable() {
        tableViewController.tableView.separatorColor = UIColor.gray
        tableViewController.tableView.frame = self.bounds
        tableViewController.tableView.rowHeight = 230
        tableViewController.tableView.register(RecipeViewCell.self, forCellReuseIdentifier: cellIndentifier)
        tableViewController.tableView.delegate = self
        tableViewController.tableView.dataSource = self
    }
    func reloadCell() {
        tableViewController.tableView.reloadData() 
    }
}

extension RecipeTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier, for: indexPath) as? RecipeViewCell {
            let recipeId = arrayItems[indexPath.row]
            let recipe = coordinator?.getRecipe(recipeId)
            cell.recipeView.recipeViewDelegate = self
            cell.refresh(recipe!)
            cell.recipeView.updateImage(image: (coordinator?.getImage(recipe!.id))! )
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipeId = arrayItems[indexPath.row]
        let recipe = coordinator?.getRecipe(recipeId)
        coordinator?.eventOccurred(with: .recipeTapped, recipe: recipe!)
    }
    
    // Set the spacing between sections
      func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
          return cellSpacingHeight
      }
}

extension RecipeTableView: RecipeViewDelegate {
    func pushCheckFavorite(recipe: RecipeInfoData) {
        coordinator?.eventOccurred(with: .favoriteTapped, recipe: recipe)
    }
}
    
