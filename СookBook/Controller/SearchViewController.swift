//
//  SearchViewController.swift
//  СookBook
//
//  Created by Vladimir V. on 28.02.2023.
//

import SwiftUI

fileprivate let START_NOT_FIND_TEXT = "Let's find the tastiest recipe\n🍕"
fileprivate let NOT_FIND_TEXT = "We don't have the recipes you're looking for.\n\nTry looking for another 🔎"


final class SearchViewController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    var recipeTableView: RecipeTableView?
    //var searchHeaderView: SearchHeaderView?
    var searchData:[Int] = []
    
    private let searchNotFoundView: SearchNotFoundView = {
        let view = SearchNotFoundView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = false
        view.setText(START_NOT_FIND_TEXT)
        return view
    }()
    
    private let searchHeaderView: SearchHeaderView = {
        let view = SearchHeaderView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.gray.cgColor
        view.searchButton.addTarget(SearchViewController.self, action: #selector(serchPressed), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        searchHeaderView.searchField.delegate = self
        recipeTableView = RecipeTableView()
        recipeTableView!.isHidden = true
        
       
        view.addSubview(recipeTableView!)
        view.addSubview(searchHeaderView)
        view.addSubview(searchNotFoundView)
        
        recipeTableView!.translatesAutoresizingMaskIntoConstraints = false
 
        
        NSLayoutConstraint.activate([
            searchHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchHeaderView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            searchHeaderView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            searchHeaderView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            recipeTableView!.topAnchor.constraint(equalTo: searchHeaderView.bottomAnchor, constant: 10),
            recipeTableView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recipeTableView!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recipeTableView!.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            self.searchNotFoundView.topAnchor.constraint(equalTo: self.searchHeaderView.bottomAnchor, constant: 10),
            self.searchNotFoundView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            self.searchNotFoundView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10),
            self.searchNotFoundView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10),
        ])
        
        
        recipeTableView?.coordinator = coordinator
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        didUpdateView()
    }

    @objc func serchPressed(_ sender: UIButton) {
        searchHeaderView.searchField.endEditing(true)
    }
    
    func isHiddenResult(_ flag: Bool) {
        self.recipeTableView?.isHidden = !flag
        self.searchNotFoundView.isHidden = flag
    }
    
    func didUpdateView() {
        DispatchQueue.main.async {
            self.recipeTableView?.arrayItems = (self.coordinator?.cookManager?.cookData.searchRecipes)!
            self.isHiddenResult(!(self.recipeTableView?.arrayItems.isEmpty)!)
            self.recipeTableView!.tableViewController.tableView.reloadData()
        }
    }
    
    func didUpdateImage(recipeId: Int) {
        print(recipeId)
    }
}

extension SearchViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchHeaderView.searchField.endEditing(true)
        return true
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
