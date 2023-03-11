//
//  FavoriteViewController.swift
//  СookBook
//
//  Created by Vladimir V. on 28.02.2023.
//

import UIKit

final class FavoriteViewController: UIViewController, Coordinating {
    
    let NOT_FIND_TEXT = "You haven't added any of your favorite recipes 😥"
    let recipeTableView = RecipeTableView()
    let emptyFavoriteView = SearchNotFoundView()

    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
    }
    
    func setupView(){
        view.backgroundColor = .white
        view.addSubview(recipeTableView)
        view.addSubview(emptyFavoriteView)
        emptyFavoriteView.setText(NOT_FIND_TEXT)
        recipeTableView.translatesAutoresizingMaskIntoConstraints = false
        recipeTableView.coordinator = coordinator
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            recipeTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            recipeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recipeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recipeTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
        NSLayoutConstraint.activate([
            self.emptyFavoriteView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.emptyFavoriteView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            self.emptyFavoriteView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10),
            self.emptyFavoriteView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10),
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        didUpdateView()
    }
    
    func isHiddenResult(_ flag: Bool) {
        self.recipeTableView.isHidden = !flag
        self.emptyFavoriteView.isHidden = flag
    }
    
    func didUpdateView() {
        recipeTableView.arrayItems = (coordinator?.cookManager?.cookData.favoriteRecipes)!
        self.isHiddenResult(!(coordinator?.cookManager?.cookData.favoriteRecipes)!.isEmpty)
        DispatchQueue.main.async {
            self.recipeTableView.tableViewController.tableView.reloadData()
        }
    }
    func didUpdateImage(recipeId: Int) {}
}
