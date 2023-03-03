//
//  TabBarController.swift
//  СookBook
//
//  Created by Vladimir V. on 28.02.2023.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewControllers = [
            setUpViewController(with: .homeVC),
            setUpViewController(with: .categoriesVC),
            setUpViewController(with: .searchVC),
            setUpViewController(with: .favoriteVC)
        ]
        view.tintColor = .black
        self.tabBar.backgroundColor = .white
    }

    func setUpViewController(with type: TypeViewController) -> UIViewController {
        var vc: UIViewController?
        switch type {
        case .homeVC:
            vc = MainViewController()
            (vc as! MainViewController).coordinator = coordinator
            vc?.tabBarItem.title = "Home"
            vc?.tabBarItem.image = UIImage(named: "Home")
            coordinator?.activeViewController = vc
        case .categoriesVC:
            let newCoordinator = MainCoordinator()
            let navVC = UINavigationController()
            newCoordinator.navigationController = navVC

            let categorieVC = CategoriesViewController()
            categorieVC.coordinator = coordinator
            navVC.setViewControllers([categorieVC], animated: false)
            navVC.tabBarItem.title = "Categorie"
            navVC.tabBarItem.image = UIImage(named: "Categorie")
            coordinator?.children?.append(newCoordinator)
            vc = navVC
        case .searchVC:
            vc = SearchViewController()
            (vc as! SearchViewController).coordinator = coordinator
            vc?.tabBarItem.title = "Search"
            vc?.tabBarItem.image = UIImage(named: "Search")
        case .favoriteVC:
            vc = FavoriteViewController()
            (vc as! FavoriteViewController).coordinator = coordinator
            vc?.tabBarItem.title = "Favorite"
            vc?.tabBarItem.image = UIImage(named: "Favorite")
            self.coordinator?.addController(type: .favoriteVC, controller: vc as! Coordinating)
        default:
            print("Error!!")
        }
        return vc!
    }

}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        coordinator?.activeViewController = viewController
        return true
    }
}
