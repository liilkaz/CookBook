//
//  MainViewControllerD.swift
//  СookBook
//
//  Created by dmitrii on 04.03.2023.
//

import UIKit

class MainViewControllerD: UIViewController, Coordinating {
    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainView = MainViewD()
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
        
    }
    
    func didUpdateImage(imageString: String) {
        
    }
    

    
    
}
