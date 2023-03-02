//
//  ViewController.swift
//  СookBook
//
//  Created by Лилия Феодотова on 26.02.2023.
//

import UIKit

class MainViewController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addLabelText((self.tabBarItem.title ?? ""))
    }
    func didUpdateView() {
        
    }
    func didUpdateImage(imageString: String) {
        print(imageString)
    }
}




