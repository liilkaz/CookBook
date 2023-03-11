//
//  CellBuilder.swift
//  CompositionalLayout
//
//  Created by Vladimir V. on 07.03.2023.
//

import UIKit

public class CellBuilder {
    public static func getTrendingCell(viewDelegate cellClass: Any, collectionView: UICollectionView, indexPath: IndexPath, recipeInfoData: Any, recipeImage: Any) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trendRecipe", for: indexPath) as? TranderRecipeCollectionViewCell {
            let recipeInfo = (recipeInfoData as? RecipeInfoData)!
            let image = (recipeImage as? UIImage)!
            cell.setup(recipeInfo: recipeInfo)
            cell.recipeView.recipeViewDelegate = cellClass as? any RecipeViewDelegate
            cell.recipeView.reloadRecipe(recipe: recipeInfo)
            cell.recipeView.updateImage(image: image)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    public static func getLastRecipeCell(viewDelegate cellClass: Any, collectionView: UICollectionView, indexPath: IndexPath, recipeInfoData: Any, recipeImage: Any) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lastWatchRecipe", for: indexPath) as? LastWatchRecipeCollectionViewCell {
            let recipeInfo = (recipeInfoData as? RecipeInfoData)!
            let image = (recipeImage as? UIImage)!
            cell.setup(recipeInfo: recipeInfo)
            cell.recipeView.recipeViewDelegate = cellClass as? any RecipeViewDelegate
            cell.recipeView.reloadRecipe(recipe: recipeInfo)
            cell.recipeView.updateImage(image: image)
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
    public static func getTrendTextCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trendText", for: indexPath) as? TrendText {
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
