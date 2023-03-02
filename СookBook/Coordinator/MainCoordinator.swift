//
//  MainCoordinator.swift
//  СookBook
//
//  Created by Vladimir V. on 28.02.2023.
//

import Foundation
import UIKit




final class MainCoordinator: Coordinator {
    private var viewControllers = Dictionary<TypeViewController, Coordinating>()
    
    var imagesDictionary = Dictionary<String, UIImage>()
    var cookManager: CookManager? = nil
    var navigationController: UINavigationController?
    var children: [Coordinator]? = nil
    var activeViewController: UIViewController?
    var activeTypeVC: TypeViewController = .launchScreenVC
    
    
    func eventOccurred(with type: Event, recipe: RecipeData) {
        switch type {
        case .startTapped:
            let vc = TabBarController()
            vc.coordinator = self
            navigationController?.setViewControllers([vc], animated: true)
            activeViewController = vc
            activeTypeVC = .homeVC
        case .recipeTapped:
            let vc = RecipeViewController()
            vc.coordinator = self
            vc.recipe = recipe
            navigationController?.present(vc, animated: true)
            activeViewController = vc
            activeTypeVC = .recipeVC
        case .listRecipeTapped:
            let vc = ListRecipeViewController()
            navigationController?.pushViewController(vc, animated: true)
            vc.coordinator = self
            activeViewController = vc
        case .favoriteTapped:
            cookManager!.checkFavoriteRecipe(recipe: recipe)
            viewControllers[.favoriteVC]!.didUpdateView()
        }
    }
    
    func start() {
        let vc = LaunchScreenVC()
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
        cookManager?.delegate = self
        cookManager!.fetchPopularRecipe()
    }
    
    func setActiveViewController(with viewController: UIViewController) {
        activeViewController = viewController
    }
    
    func addController(type: TypeViewController, controller: Coordinating) {
        if viewControllers.keys.contains(type) {
            assertionFailure("There was an issue  adding viewController in MainCoordinator")
        }
        viewControllers[type] = controller
    }
    
    func getImage(_ urlString: String) -> UIImage {
        if !imagesDictionary.keys.contains(urlString) {
            self.load(urlString: urlString)
            return UIImage()
        }
        return imagesDictionary[urlString]!
    }
    
    private func addImage(_ urlString: String) {
        if !imagesDictionary.keys.contains(urlString) {
            self.load(urlString: urlString)
        }
    }
        
    private func load(urlString: String) {
        let url = URL(string: urlString)!
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self?.imagesDictionary[urlString] = UIImage(data:  data)!
                    self?.updateActiveViewController()
                }
            }
        }
    }
}


extension MainCoordinator: CookManagerDelegate {
    func didUpdateSearchRecipesData(_ cookManager: CookManager, recipes: [RecipeData]) {
        self.cookManager!.cookData.searchRecipes = recipes
        self.updateActiveViewController()
    }
    
    func didUpdateRecipe(_ cookManager: CookManager, recipe: RecipeData) {
        print("didUpdateRecipe")
    }
    
    func didUpdatePopularRecipesData(_ cookManager: CookManager, recipes: [RecipeData]) {
        for item in recipes {
            self.addImage(item.image)
        }
        self.cookManager!.cookData.popularRecipes = recipes
        self.cookManager!.cookData.favoriteRecipes = recipes
        print("didUpdatePopularRecipesData <<---- ToDo")
        self.updateActiveViewController()
    }
    
    func updateActiveViewController() {
        guard let vc = (activeViewController as? Coordinating) else { return }
        vc.didUpdateView()
    }
    
    func didFailWithError(error: Error) {
        print("didFailWithError")
    }
    
}
