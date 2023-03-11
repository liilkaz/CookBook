//
//  RecipeCollectionViewCell.swift
//  CompositionalLayout
//
//  Created by Vladimir V. on 07.03.2023.
//

import UIKit
public class LastWatchRecipeCollectionViewCell: RecipeCollectionViewCell {
    override init(frame: CGRect) {
        super.init(ShortRecipeView(), frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(_ recipeView: RecipeView, frame: CGRect) {
        fatalError("init(_:frame:) has not been implemented")
    }
}

public class TranderRecipeCollectionViewCell: RecipeCollectionViewCell {
    override init(frame: CGRect) {
        super.init(TrendRecipeView(), frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(_ recipeView: RecipeView, frame: CGRect) {
        fatalError("init(_:frame:) has not been implemented")
    }
}

public class RecipeCollectionViewCell: UICollectionViewCell {
    let typeRecipeView:TypeRecipeView
    var recipeView: RecipeView

    override init(frame: CGRect) {
        fatalError("init(type:frame:) has not been implemented")
    }

    required init(_ recipeView: RecipeView, frame: CGRect) {
        typeRecipeView = .recipeDefault
        self.recipeView = recipeView
        self.recipeView.translatesAutoresizingMaskIntoConstraints = false
        super.init(frame: frame)
        self.contentView.addSubview(self.recipeView)

        NSLayoutConstraint.activate([
            self.recipeView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.recipeView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.recipeView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.recipeView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(recipeInfo: RecipeInfoData) {
        self.recipeView.reloadRecipe(recipe: recipeInfo)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
}
