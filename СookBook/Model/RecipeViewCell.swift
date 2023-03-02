//
//  RecipeViewCell.swift
//  СookBook
//
//  Created by Vladimir V. on 01.03.2023.
//

import UIKit

class RecipeViewCell: UITableViewCell, RecipeViewDelegate {
    
    var textInformation: UILabel = {
       let textLabel = UILabel()
        textLabel.text = "Text"
        textLabel.textColor = .blue
        textLabel.font = UIFont.init(name: "Roboto-Bold", size: 16)
        textLabel.textAlignment = .center
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.adjustsFontSizeToFitWidth = true
        return textLabel
    }()

    var viewCell: RecipeView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        viewCell =  RecipeView()
        viewCell?.recipeViewDelegate = self
        contentView.addSubview(viewCell!)
        viewCell!.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
                viewCell!.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
                viewCell!.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
                viewCell!.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5),
                viewCell!.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func refresh(_ recipe: RecipeData) {
        viewCell!.reloadRecipe(recipe: recipe)
    }

    func pushCheckFavorite(recipe: RecipeData) {
        print("RecipeViewCell")
    }
}
