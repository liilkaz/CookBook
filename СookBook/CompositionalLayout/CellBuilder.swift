//
//  CellBuilder.swift
//  CompositionalLayout
//
//  Created by Vladimir V. on 07.03.2023.
//

import UIKit

public class CellBuilder {
    public static func getTrendingCell(viewDelegate cellClass: Any, collectionView: UICollectionView, indexPath: IndexPath, recipeInfoData: Any, recipeImage: Any) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipe", for: indexPath) as? RecipeCollectionViewCell {
            let recipeInfo = (recipeInfoData as? RecipeInfoData)!
            let image = (recipeImage as? UIImage)!
            cell.setup(recipeInfo: recipeInfo)
            cell.container.recipeViewDelegate = cellClass as? any RecipeViewDelegate
            cell.container.reloadRecipe(recipe: recipeInfo)
            cell.container.updateImage(image: image)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    public static func getLastRecipeCell(viewDelegate cellClass: Any, collectionView: UICollectionView, indexPath: IndexPath, recipeInfoData: Any, recipeImage: Any) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipe", for: indexPath) as? RecipeCollectionViewCell {
            let recipeInfo = (recipeInfoData as? RecipeInfoData)!
            let image = (recipeImage as? UIImage)!
            cell.setup(recipeInfo: recipeInfo)
            cell.container.recipeViewDelegate = cellClass as? any RecipeViewDelegate
            cell.container.reloadRecipe(recipe: recipeInfo)
            cell.container.updateImage(image: image)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    public static func getTextCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "text", for: indexPath) as? Text {
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
