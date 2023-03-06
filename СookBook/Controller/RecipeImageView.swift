//
//  RecipeView.swift
//  СookBook
//
//  Created by Vladimir V. on 28.02.2023.
//

import Foundation
import UIKit

protocol RecipeViewDelegate {
    func pushCheckFavorite(recipe: RecipeInfoData) //toDoStruct
}

final class RecipeView: UIView {
    private var recipe = RecipeInfoData(from: RecipeData(id: 1, title: "", image: "", imageType: ""))
    
    
    var recipeViewDelegate: RecipeViewDelegate?
    
    var textInformation: UILabel = {
       let textLabel = UILabel()
        textLabel.text = "Text1"
        textLabel.textColor = .white
        textLabel.font = UIFont.init(name: "Roboto-Bold", size: 16)
        textLabel.textAlignment = .center
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.adjustsFontSizeToFitWidth = true
        return textLabel
    }()
    
    private lazy var favoriteImage: UIImageView = {
        let imageView = UIImageView()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pushFavoriteImage(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    var recipeImage: UIImageView = {
       let recipeImage = UIImageView()
        recipeImage.image = UIImage(named: "Home")
        recipeImage.contentMode = .scaleAspectFit
        recipeImage.translatesAutoresizingMaskIntoConstraints = false
        return recipeImage
    }()
    
    required init() {
        super.init(frame: CGRect.zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.backgroundColor = .clear
        self.addSubview(recipeImage)
        self.addSubview(favoriteImage)
        self.addSubview(textInformation)
        
        NSLayoutConstraint.activate([
            recipeImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 1),
            recipeImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -1),
            recipeImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1),
            recipeImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 1),
            
            favoriteImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            favoriteImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            favoriteImage.widthAnchor.constraint(equalToConstant: 40),
            favoriteImage.heightAnchor.constraint(equalTo: favoriteImage.widthAnchor),
            
            textInformation.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            textInformation.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
        ])
    }
    
    func updateImage(image: UIImage) {
        self.recipeImage.image = image
    }
    
    func reloadRecipe(recipe: RecipeInfoData) {
        self.recipe = recipe
        self.textInformation.text = self.recipe.title
        if self.recipe.favorite {
            favoriteImage.image = UIImage(named: "FavoriteOn")
        } else {
            favoriteImage.image = UIImage(named: "FavoriteOff")
        }
    }
    
    @objc func pushFavoriteImage(tapGestureRecognizer: UITapGestureRecognizer) {
        recipeViewDelegate?.pushCheckFavorite(recipe: self.recipe)
    }
}
