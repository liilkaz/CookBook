//
//  SearchViewController.swift
//  СookBook
//
//  Created by Vladimir V. on 28.02.2023.
//

import SwiftUI

final class SearchViewController: UIViewController, Coordinating {
    
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
