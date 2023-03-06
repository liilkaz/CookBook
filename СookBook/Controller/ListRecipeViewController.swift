//
//  ListRecipeViewController.swift
//  СookBook
//
//  Created by Vladimir V. on 28.02.2023.
//

import UIKit

final class ListRecipeViewController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    var typeMeal: TypeMeal?
    var recipeTableView: RecipeTableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = typeMeal!.rawValue
        
        setipUi()
        didUpdateView()
        
    }
    
    func setipUi() {
        recipeTableView = RecipeTableView()
        recipeTableView!.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recipeTableView!)
        NSLayoutConstraint.activate([
            recipeTableView!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            recipeTableView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recipeTableView!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recipeTableView!.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        //recipeTableView?.arrayItems = listResiperData
        recipeTableView?.coordinator = coordinator
    }
    
    func didUpdateView() {
        recipeTableView?.arrayItems = (coordinator?.cookManager?.cookData.typeMealDict[typeMeal!])!
        DispatchQueue.main.async {
            self.recipeTableView!.tableViewController.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        recipeTableView!.reloadCell()
    }
    
    func didUpdateImage(recipeId: Int) {
        print(recipeId)
    }
}
