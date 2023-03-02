//
//  RecipeTableView.swift
//  СookBook
//
//  Created by Vladimir V. on 02.03.2023.
//

import UIKit

final class RecipeTableView: UIView {
    var coordinator: Coordinator?
    var tableViewController = UITableViewController(style: .plain)
    var cellIndentifier = "Cell"
    var arrayItems:[RecipeData] = [RecipeData(id: 1, title: "Hello", image: "", imageType: "")]

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
        tableViewController.tableView.separatorColor = UIColor.green
        tableViewController.tableView.frame = self.bounds
        tableViewController.tableView.rowHeight = 100
        tableViewController.tableView.register(RecipeViewCell.self, forCellReuseIdentifier: cellIndentifier)
        tableViewController.tableView.delegate = self
        tableViewController.tableView.dataSource = self
    }
}

extension RecipeTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier, for: indexPath) as? RecipeViewCell {
            let recipe = arrayItems[indexPath.row]
            cell.viewCell?.recipeViewDelegate = self
            cell.refresh(recipe)
            cell.viewCell?.updateImage(image: (coordinator?.getImage(recipe.image))! )
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // _ = tableView.dequeueReusableCell(withIdentifier: cellIndentifier, for: indexPath)
        coordinator?.eventOccurred(with: .recipeTapped, recipe: arrayItems[indexPath.row])
    }
}

extension RecipeTableView: RecipeViewDelegate {
    func pushCheckFavorite(recipe: RecipeData) {
        coordinator?.eventOccurred(with: .favoriteTapped, recipe: recipe)
    }
}
    
