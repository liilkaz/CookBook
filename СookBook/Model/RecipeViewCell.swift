//
//  RecipeViewCell.swift
//  СookBook
//
//  Created by Vladimir V. on 01.03.2023.
//

import UIKit

class RecipeViewCell: UITableViewCell, RecipeViewDelegate {

    var recipeView: RecipeView = {
        let view = RecipeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(recipeView)
        recipeView.recipeViewDelegate = self

        NSLayoutConstraint.activate([
            self.recipeView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.recipeView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.recipeView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.recipeView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func refresh(_ recipe: RecipeInfoData) {
        recipeView.reloadRecipe(recipe: recipe)
    }

    func pushCheckFavorite(recipe: RecipeInfoData) {}

}
