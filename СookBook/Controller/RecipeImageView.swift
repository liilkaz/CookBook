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

enum TypeRecipeView {
    case trendingNowCell
    case lastRecipesCell
    case recipeInfo
    case recipeTableCell
    case recipeDefault
}

class TrendRecipeView: RecipeView {
    override func layoutConstraint()
    {
        NSLayoutConstraint.activate([
            self.recipeImage.topAnchor.constraint(equalTo: self.topAnchor),
            self.recipeImage.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.recipeImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -60),
            self.recipeImage.rightAnchor.constraint(equalTo: self.rightAnchor),
            //self.recipeImage.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.favoriteImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            //self.favoriteImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            self.favoriteImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            self.favoriteImage.widthAnchor.constraint(equalToConstant: 30),
            self.favoriteImage.heightAnchor.constraint(equalTo: self.favoriteImage.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 0),
            self.titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5)
        ])

        NSLayoutConstraint.activate([
            self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
            //self.subtitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.subtitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.subtitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
            //self.subtitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20)
        ])
        self.backgroundColor = .white
        self.subtitleLabel.backgroundColor = .clear
        self.titleLabel.backgroundColor = .clear
        
        self.titleLabel.font = UIFont.preferredFont(forTextStyle: .headline).withSize(16)
        self.subtitleLabel.font = UIFont.preferredFont(forTextStyle: .headline).withSize(12)
        
        self.titleLabel.numberOfLines = 1
        self.subtitleLabel.numberOfLines = 1
        (self.titleLabel as? PaddingLabel)!.resetValue(withInsets: 8, 0, 16, 0)
        (self.subtitleLabel as? PaddingLabel)!.resetValue(withInsets: 8, 0, 16, 0)
    }
    
    override func setSubText(recipe: RecipeInfoData) {
        self.titleLabel.text = recipe.title
        self.subtitleLabel.text = recipe.subText()
    }
}


class ShortRecipeView: RecipeView {
    override func layoutConstraint()
    {
        NSLayoutConstraint.activate([
            self.recipeImage.topAnchor.constraint(equalTo: self.topAnchor),
            self.recipeImage.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.recipeImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -80),
            self.recipeImage.rightAnchor.constraint(equalTo: self.rightAnchor),
            //self.recipeImage.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.favoriteImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            //self.favoriteImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            self.favoriteImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            self.favoriteImage.widthAnchor.constraint(equalToConstant: 30),
            self.favoriteImage.heightAnchor.constraint(equalTo: self.favoriteImage.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 0),
            self.titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5)
        ])

        NSLayoutConstraint.activate([
            self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
            //self.subtitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.subtitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.subtitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
            //self.subtitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20)
        ])
        self.backgroundColor = .white
        self.subtitleLabel.backgroundColor = .clear
        self.titleLabel.backgroundColor = .clear
        
        self.titleLabel.font = UIFont.preferredFont(forTextStyle: .headline).withSize(16)
        self.subtitleLabel.font = UIFont.preferredFont(forTextStyle: .headline).withSize(12)
        
        self.titleLabel.numberOfLines = 2
        self.subtitleLabel.numberOfLines = 1
        
        (self.titleLabel as? PaddingLabel)!.resetValue(withInsets: 8, 0, 16, 0)
        (self.subtitleLabel as? PaddingLabel)!.resetValue(withInsets: 8, 0, 16, 0)
    }
    override func setSubText(recipe: RecipeInfoData) {
        self.titleLabel.text = recipe.title
        self.subtitleLabel.text = recipe.subText()
    }
    
}

class Base {
   var lightSaberColor: String { "base" }
}

class Red: Base {
   override var lightSaberColor: String { "red" }
}

class RecipeView: UIView {
    private var recipeInfo = RecipeInfoData(from: RecipeData(id: 1, title: "", image: "", imageType: ""))
    var recipeViewDelegate: RecipeViewDelegate?
    
    lazy var favoriteImage: UIImageView = {
        let imageView = UIImageView()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pushFavoriteImage(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label: UILabel = PaddingLabel(withInsets: 8, 8, 16, 16)
        label.text = "FEATURED"
        label.font = UIFont.preferredFont(forTextStyle: .headline).withSize(26)
        label.numberOfLines = 3
        label.backgroundColor = UIColor(white: 1, alpha: 0.5)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textAlignment = .left
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.sizeToFit()
        
        return label
    }()

    var subtitleLabel: UILabel = {
        let label: UILabel = PaddingLabel(withInsets: 8, 8, 16, 16)
        label.text = "Some subtitle"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        label.backgroundColor = UIColor(white: 1, alpha: 0.5)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textAlignment = .left
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.sizeToFit()
        
        return label
    }()
    

    var recipeImage: UIImageView = {
       let recipeImage = UIImageView()
        recipeImage.image = UIImage(named: "NoImage")
        recipeImage.contentMode = .scaleAspectFill
        recipeImage.layer.masksToBounds = true
        recipeImage.layer.cornerRadius = 20
        recipeImage.translatesAutoresizingMaskIntoConstraints = false
        return recipeImage
    }()
    
    required init() {
        super.init(frame: CGRect.zero)
        
//        switch type {
//        case .trendingNowCell:
//            break
//        case .lastRecipesCell:
//            break
//        case .recipeInfo:
//            break
//        case .recipeTableCell:
//            break
//        case .recipeDefault:
//            break
//        }
            
        self.addSubview(self.recipeImage)
        self.addSubview(self.titleLabel)
        self.addSubview(self.subtitleLabel)
        //self.backgroundColor = .red
        self.addSubview(self.favoriteImage)
        layoutConstraint()


        
        setup()
        reloadRecipe(recipe: recipeInfo)
        
    }
    func layoutConstraint(){
        NSLayoutConstraint.activate([
            self.recipeImage.topAnchor.constraint(equalTo: self.topAnchor),
            self.recipeImage.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.recipeImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.recipeImage.rightAnchor.constraint(equalTo: self.rightAnchor),
            //self.recipeImage.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.favoriteImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            //self.favoriteImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            self.favoriteImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            self.favoriteImage.widthAnchor.constraint(equalToConstant: 30),
            self.favoriteImage.heightAnchor.constraint(equalTo: self.favoriteImage.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            self.titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            self.titleLabel.rightAnchor.constraint(equalTo: self.favoriteImage.leftAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            self.subtitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.subtitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            //self.subtitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        //self.backgroundColor = UIColor.white
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.cornerRadius = 20
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = CGSize(width: 0, height: 0)

    }
    
    func updateImage(image: UIImage) {
       self.recipeImage.image  = image
    }
    
    func setSubText(recipe: RecipeInfoData) {
        self.titleLabel.text = self.recipeInfo.title
        self.subtitleLabel.text = self.recipeInfo.subReadyTimeText()
    }
    
    func reloadRecipe(recipe: RecipeInfoData) {
        self.recipeInfo = recipe
        
        setSubText(recipe: recipe)
        if self.recipeInfo.favorite {
            favoriteImage.image = UIImage(named: "FavoriteOn")
        } else {
            favoriteImage.image = UIImage(named: "FavoriteOff")
        }
        self.subtitleLabel.isHidden = self.subtitleLabel.text!.isEmpty
    }
    
    @objc func pushFavoriteImage(tapGestureRecognizer: UITapGestureRecognizer) {
        recipeViewDelegate?.pushCheckFavorite(recipe: self.recipeInfo)
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

class PaddingLabel: UILabel {

    var topInset: CGFloat
    var bottomInset: CGFloat
    var leftInset: CGFloat
    var rightInset: CGFloat

    required init(withInsets top: CGFloat, _ bottom: CGFloat,_ left: CGFloat,_ right: CGFloat) {
        self.topInset = top
        self.bottomInset = bottom
        self.leftInset = left
        self.rightInset = right
        super.init(frame: CGRect.zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resetValue(withInsets top: CGFloat, _ bottom: CGFloat,_ left: CGFloat,_ right: CGFloat) {
        self.topInset = top
        self.bottomInset = bottom
        self.leftInset = left
        self.rightInset = right
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
}
