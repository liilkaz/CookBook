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
    
    var imagesDictionary = Dictionary<Int, UIImage>()
    var cookManager: CookManager? = nil
    var navigationController: UINavigationController?
    var parent: Coordinator? = nil
    var children: [Coordinator]? = nil
    var activeViewController: [UIViewController]?
    var activeTypeVC: TypeViewController = .launchScreenVC
    
    func eventOccurred(with type: Event, recipe: RecipeInfoData, typeMeal: TypeMeal) {
        switch type {
        case .startTapped:
            let vc = TabBarController()
            vc.coordinator = self
            navigationController?.setViewControllers([vc], animated: true)
            activeViewController = [vc]
            activeTypeVC = .homeVC
        case .recipeTapped:
            cookManager!.addHistoriRecipe(recipe: recipe)
            self.updateActiveViewController()
            let vc = RecipeViewController()
            vc.coordinator = self
            vc.recipeInfo = recipe
            navigationController!.present(vc, animated: true)
            activeViewController?.append(vc)
            //activeTypeVC = .recipeVC
        case .listRecipeTapped:
            let vc = ListRecipeViewController()
            children![0].navigationController!.pushViewController(vc, animated: true)
            vc.coordinator = self
            vc.typeMeal = typeMeal
            activeViewController = [vc]
        case .favoriteTapped:
            cookManager!.checkFavoriteRecipe(recipe: recipe)
            viewControllers[.favoriteVC]!.didUpdateView()
            self.updateActiveViewController()
        }
    }
    
    func start() {
        let vc = LaunchScreenVC()
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
        cookManager?.delegate = self
        cookManager!.fetchPopularRecipe()
        
        for typeMeal in TypeMeal.allCases {
            cookManager!.fetchTypePopularRecipe(type: typeMeal)
        }
    }
    
    func addController(type: TypeViewController, controller: Coordinating) {
        if viewControllers.keys.contains(type) {
            assertionFailure("There was an issue  adding viewController in MainCoordinator")
        }
        viewControllers[type] = controller
    }
    
    func loadImages(_ recipeId: Int) {
        if !imagesDictionary.keys.contains(recipeId) {
            cookManager!.fetchRecipeImage(recipeId: recipeId)
        }
    }
    
    func getImage(_ recipeId: Int) -> UIImage {
        if !imagesDictionary.keys.contains(recipeId) {
            cookManager!.fetchRecipeImage(recipeId: recipeId)
            return UIImage(named: "NoImage")!
        }
        return imagesDictionary[recipeId]!
    }

    func getRecipe(_ recipeId: Int) -> RecipeInfoData {
        if !(cookManager?.cookData.recipeDict.keys.contains(recipeId))!{
            cookManager!.fetchRecipe(recipeId: recipeId)
            return RecipeInfoData(from: RecipeData(id: recipeId, title: "Hello", image: "", imageType: ""))
        }
        var recipeInfo = cookManager!.cookData.recipeDict[recipeId]
        recipeInfo?.favorite = cookManager!.cookData.isFavoriteRecipe(recipeId: recipeId)
        return recipeInfo!
    }
}

extension MainCoordinator: CookManagerDelegate {
    func didLoadImage(_ cookManager: CookManager, recipeId: Int, data: Data) {
        self.imagesDictionary[recipeId] = UIImage(data:  data)!
        self.updateActiveViewController()
    }
    
    func didUpdateSearchRecipesData(_ cookManager: CookManager, recipes: [RecipeData]) {
        self.cookManager!.cookData.setSearchRecipe(array: recipes)
        self.updateActiveViewController()
    }
    
    func didUpdateRecipe(_ cookManager: CookManager, recipeInfoData: RecipeInfoData) { //Каждый раз когда запрашиваем у менеджера данные с джсона, то обновляев данные о рецепте
        self.updateActiveViewController()
    }
    
    func didUpdatePopularRecipesData(_ cookManager: CookManager, recipes: [RecipeData]) {
        for item in recipes {
            self.loadImages(item.id)
        }
        self.cookManager!.cookData.setPopularRecipes(array: recipes)
        self.updateActiveViewController()
    }
    
    func didUpdateTypePopularRecipesData(_ cookManager: CookManager, recipes: [RecipeData], typeMeal: TypeMeal) {
        self.loadImages(recipes[0].id)
        self.cookManager!.cookData.setTypeMealRecipes(typeMeal: typeMeal, array: recipes)
//        print("didUpdatePopularRecipesData <<---- ToDo")
    }
    
    func updateActiveViewController() {
        if (activeViewController == nil) { return }
        for viewController in activeViewController! {
            guard let vc = (viewController as? Coordinating) else { return }
            vc.didUpdateView()
        }
    }
    
    func didFailWithError(error: Error) {
        print("didFailWithError")
    }
}
