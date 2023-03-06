//
//  LaunchScreenVC.swift
//  СookBook
//
//  Created by Vladimir V. on 28.02.2023.
//

import Foundation
import UIKit

final class LaunchScreenVC : UIViewController {
    var coordinator: Coordinator?
    
    let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "bg")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let labelText: UILabel = {
        let label = UILabel()
        label.text = "cook\n #WithMe"
        label.font = .systemFont(ofSize: 56, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelSecondText: UILabel = {
        let label = UILabel()
        label.text = "Find best recipes for cooking"
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstreints()
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 220, height: 55))
        view.addSubview(button)
        button.center = view.center
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.setTitle(" ", for: .normal)
    }
    @objc func didTapButton() {
        coordinator?.eventOccurred(with: .startTapped)
    }
    
    func setupView(){
        view.addSubview(backgroundImage)
        view.addSubview(stack)
        stack.addArrangedSubview(labelText)
        stack.addArrangedSubview(labelSecondText)
    }
    
    func setConstreints(){
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),

            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 30)
        ])
    }
}
