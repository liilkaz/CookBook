//
//  MainViewControllerD.swift
//  СookBook
//
//  Created by dmitrii on 04.03.2023.
//

import UIKit

class MainViewControllerD: UIViewController, Coordinating {
    let mainView = MainViewD()

    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainView)
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    func didUpdateView() {
        //mainView
        
    }
    
    func didUpdateImage(recipeId: Int) {
        //
    }

    
}
