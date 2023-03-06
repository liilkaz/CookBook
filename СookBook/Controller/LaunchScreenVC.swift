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
    
    let progressBar: UIProgressView = {
        let progress = UIProgressView()
        progress.progressTintColor = .white
        progress.setProgress(0, animated: false)
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    let labelTapText: UILabel = {
        let label = UILabel()
        label.text = "Tap to continue"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.layer.backgroundColor = .init(gray: 1, alpha: 0.5)
        label.layer.cornerRadius = 5
        label.textColor = .white
        label.textAlignment = .center
        label.alpha = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.contentMode = .center
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
        
        Timer.scheduledTimer(timeInterval: 0.03, target: self, selector: #selector(updateProgressView), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(animatedTap), userInfo: nil, repeats: true)
        addActions()
    }
    
    @objc func updateProgressView(){
        if progressBar.progress != 1{
            progressBar.progress += 1/100
        } else{
            labelTapText.isHidden = false
            UIView.animate(withDuration: 0.4) {
                self.progressBar.alpha = 0
                self.labelTapText.alpha = 1
            }
        }
    }
    
    @objc func animatedTap(){
        if progressBar.progress == 1{
            if labelTapText.alpha == 1{
                UIView.animate(withDuration: 0.4) {self.labelTapText.alpha = 0}
            } else{
                UIView.animate(withDuration: 0.4) {self.labelTapText.alpha = 1}
            }
        }
    }
    
    @objc func didTapView() {
        coordinator?.eventOccurred(with: .startTapped)
    }
    
    func setupView(){
        view.addSubview(backgroundImage)
        view.addSubview(stack)
        stack.addArrangedSubview(progressBar)
        stack.addSubview(labelTapText)
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
            stack.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 30),
            
            labelTapText.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            labelTapText.bottomAnchor.constraint(equalTo: labelText.topAnchor)
        ])
    }
    
    func addActions() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        view.addGestureRecognizer(tap)
    }
}
