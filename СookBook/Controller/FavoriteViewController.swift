//
//  FavoriteViewController.swift
//  СookBook
//
//  Created by Vladimir V. on 28.02.2023.
//

import UIKit

fileprivate let NOT_FIND_TEXT = "You haven't added any of your favorite recipes 😥"


final class FavoriteViewController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    var recipeTableView: RecipeTableView?

    private let emptryFavoriteView: SearchNotFoundView = {
        let view = SearchNotFoundView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = false
        view.setText(NOT_FIND_TEXT)
        return view
    }()
    
    override func viewDidLoad() {
        emptryFavoriteView.setText(NOT_FIND_TEXT)
        super.viewDidLoad()
        view.backgroundColor = .white
        recipeTableView = RecipeTableView()
        view.addSubview(recipeTableView!)
        view.addSubview(emptryFavoriteView)
        recipeTableView!.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            recipeTableView!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            recipeTableView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recipeTableView!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recipeTableView!.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
        NSLayoutConstraint.activate([
            self.emptryFavoriteView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.emptryFavoriteView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            self.emptryFavoriteView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10),
            self.emptryFavoriteView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10),
        ])
        
        recipeTableView?.coordinator = coordinator
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        didUpdateView()
    }
    
    func isHiddenResult(_ flag: Bool) {
        self.recipeTableView!.isHidden = !flag
        self.emptryFavoriteView.isHidden = flag
    }
    
    func didUpdateView() {
        recipeTableView?.arrayItems = (coordinator?.cookManager?.cookData.favoriteRecipes)!
        self.isHiddenResult(!(self.recipeTableView?.arrayItems.isEmpty)!)
        DispatchQueue.main.async {
            self.recipeTableView?.tableViewController.tableView.reloadData()
        }
    }
    func didUpdateImage(recipeId: Int) {
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

