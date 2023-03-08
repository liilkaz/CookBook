//
//  RecipeCollectionViewCell.swift
//  CompositionalLayout
//
//  Created by Vladimir V. on 07.03.2023.
//

import UIKit

public class RecipeCollectionViewCell: UICollectionViewCell {
    var container: RecipeView = {
        let view = RecipeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.container)

        NSLayoutConstraint.activate([
            self.container.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.container.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.container.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.container.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(recipeInfo: RecipeInfoData) {
        self.container.reloadRecipe(recipe: recipeInfo)
    }
    public override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))
    }
}
