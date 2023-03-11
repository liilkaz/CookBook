//
//  SearchViewController.swift
//  СookBook
//
//  Created by Vladimir V. on 28.02.2023.
//

import UIKit

final class SearchViewController: UIViewController, Coordinating {
    let START_NOT_FIND_TEXT = "Let's find the tastiest recipe\n🍕"
    let NOT_FIND_TEXT = "We don't have the recipes you're looking for.\n\nTry looking for another 🔎"
    
    let recipeTableView = RecipeTableView()
    let searchHeaderView = SearchHeaderView()
    let searchNotFoundView = SearchNotFoundView()
    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraint()
        
        searchHeaderView.searchField.delegate = self
    }
    
    func setupView(){
        view.backgroundColor = .white
        
        view.addSubview(searchHeaderView)
        view.addSubview(recipeTableView)
        view.addSubview(searchNotFoundView)
        searchHeaderView.searchButton.addTarget(nil, action: #selector(serchPressed), for: .touchUpInside)
        
        searchNotFoundView.setText(START_NOT_FIND_TEXT)
        
        recipeTableView.translatesAutoresizingMaskIntoConstraints = false
        recipeTableView.isHidden = true
        recipeTableView.coordinator = coordinator
    }
    
    func setConstraint(){
        NSLayoutConstraint.activate([
            searchHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchHeaderView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            searchHeaderView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            searchHeaderView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            recipeTableView.topAnchor.constraint(equalTo: searchHeaderView.bottomAnchor, constant: 10),
            recipeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recipeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recipeTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            searchNotFoundView.topAnchor.constraint(equalTo: searchHeaderView.bottomAnchor, constant: 10),
            searchNotFoundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            searchNotFoundView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            searchNotFoundView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        didUpdateView()
    }

    @objc func serchPressed(_ sender: UIButton) {
        searchHeaderView.searchField.endEditing(true)
    }
    
    func isHiddenResult(_ flag: Bool) {
        recipeTableView.isHidden = !flag
        searchNotFoundView.isHidden = flag
    }
    
    func didUpdateView() {
        DispatchQueue.main.async {
            self.recipeTableView.arrayItems = (self.coordinator?.cookManager?.cookData.searchRecipes)!
            self.isHiddenResult(!(self.recipeTableView.arrayItems.isEmpty))
            self.recipeTableView.tableViewController.tableView.reloadData()
        }
    }
    
    func didUpdateImage(recipeId: Int) {
//        print(recipeId)
    }
}

//MARK: - UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return searchHeaderView.searchField.endEditing(true)
    }
    
    private func textFieldShouldEditing(_ textField: UITextField) -> Bool {
        if searchHeaderView.searchField.text == "" {
            return false
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if searchHeaderView.searchField.text != "" {
            coordinator?.cookManager!.fetchSearchRecipe(text: searchHeaderView.searchField.text!)
            self.searchNotFoundView.setText(NOT_FIND_TEXT) // todo set flag!!
        }
        searchHeaderView.searchField.text = ""
    }
}
