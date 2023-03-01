//
//  SceneDelegate.swift
//  СookBook
//
//  Created by Лилия Феодотова on 26.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let navVC = UINavigationController()
        navVC.isNavigationBarHidden = true
        let coordinator = MainCoordinator()
        coordinator.navigationController = navVC
        coordinator.cookManager = CookManager()
    
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        
        coordinator.start()
    }
}

