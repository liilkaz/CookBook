//
//  SearchViewController.swift
//  СookBook
//
//  Created by Vladimir V. on 28.02.2023.
//

import SwiftUI

final class SearchViewController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    var recipeTableView: RecipeTableView?
    var searchHeaderView: SearchHeaderView?
    
    var searchData:[RecipeData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        searchHeaderView = SearchHeaderView()
        searchHeaderView!.searchField.delegate = self
        recipeTableView = RecipeTableView()
        searchHeaderView!.searchButton.addTarget(self, action: #selector(serchPressed), for: .touchUpInside)
        
        
        view.addSubview(searchHeaderView!)
        view.addSubview(recipeTableView!)
        
        searchHeaderView!.translatesAutoresizingMaskIntoConstraints = false
        recipeTableView!.translatesAutoresizingMaskIntoConstraints = false
        searchHeaderView!.backgroundColor = .gray

        NSLayoutConstraint.activate([
            searchHeaderView!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchHeaderView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchHeaderView!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchHeaderView!.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            recipeTableView!.topAnchor.constraint(equalTo: searchHeaderView!.bottomAnchor, constant: 10),
            recipeTableView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recipeTableView!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recipeTableView!.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
        recipeTableView?.arrayItems = searchData
        recipeTableView?.coordinator = coordinator
    }
    
    @objc func serchPressed(_ sender: UIButton) {
        searchHeaderView!.searchField.endEditing(true)
    }
    
    func didUpdateView() {
        recipeTableView?.arrayItems = (coordinator?.cookManager?.cookData.searchRecipes)!
        DispatchQueue.main.async {
            self.recipeTableView!.tableViewController.tableView.reloadData()
        }
    }
    
    func didUpdateImage(imageString: String) {
        print(imageString)
    }
}

extension SearchViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //print(searchHeaderView!.searchField.text)
        searchHeaderView!.searchField.endEditing(true)
        return true
    }
    
    private func textFieldShouldEditing(_ textField: UITextField) -> Bool {
        if searchHeaderView!.searchField.text == "" {
            return false
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if searchHeaderView!.searchField.text != "" {
            coordinator!.cookManager!.fetchSearchRecipe(text: searchHeaderView!.searchField.text!)
        }
        searchHeaderView!.searchField.text = ""
    }
}
