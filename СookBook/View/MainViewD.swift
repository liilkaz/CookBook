//
//  MainViewD.swift
//  СookBook
//
//  Created by dmitrii on 04.03.2023.
//

import UIKit

class PreviewRecipeCard: UIView {
    private var labelDishName: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.medium)
        $0.text = "How to cook it"
        return $0
    }(UILabel())
    
    private var labelDinnerType: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        $0.textColor = UIColor.gray
        $0.text = "dinner, main dish"
        return $0
    }(UILabel())
    
    
    override init(frame: CGRect) {
        super.init(frame: CGRect())
        self.translatesAutoresizingMaskIntoConstraints = false
        let imageView = UIImageView(image: UIImage(named: "NoImage"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        self.addSubview(labelDishName)
        self.addSubview(labelDinnerType)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            
            labelDishName.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            labelDishName.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            
            labelDinnerType.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            labelDinnerType.topAnchor.constraint(equalTo: labelDishName.bottomAnchor),
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class MainViewD: UIView {
    
    private lazy var stackMain: UIStackView = {
        let stackMain = UIStackView()
        stackMain.translatesAutoresizingMaskIntoConstraints = false
        stackMain.spacing = 15
        stackMain.axis = .vertical
        stackMain.distribution = .fill
        return stackMain
    }()
    private lazy var viewMainTop: UIView = {
        let viewMainTop = UIView()
        viewMainTop.translatesAutoresizingMaskIntoConstraints = false
        viewMainTop.backgroundColor = .white
        return viewMainTop
    }()
    private lazy var labelMainTitle: UILabel = {
        let labelMainTitle = UILabel()
        labelMainTitle.translatesAutoresizingMaskIntoConstraints = false
        labelMainTitle.text = "Get amazing recipes\nfor cooking"
        labelMainTitle.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.heavy)
        labelMainTitle.backgroundColor = .white
        labelMainTitle.numberOfLines = 0
        return labelMainTitle
    }()
    
    private lazy var viewMainMiddle:UIView = {
        let viewMainMiddle = UIView()
        viewMainMiddle.translatesAutoresizingMaskIntoConstraints = false
        viewMainMiddle.backgroundColor = .white
        return viewMainMiddle
    }()
    private lazy var scrollViewTrand:UIScrollView = {
        let scrollViewTrand = UIScrollView()
        scrollViewTrand.translatesAutoresizingMaskIntoConstraints = false
        scrollViewTrand.showsHorizontalScrollIndicator = false
        return scrollViewTrand
    }()
    private lazy var stackViewTrand: UIStackView = {
        let stackViewTrand = UIStackView()
        stackViewTrand.translatesAutoresizingMaskIntoConstraints = false
        stackViewTrand.axis = .horizontal
        stackViewTrand.alignment = .center
        stackViewTrand.spacing = 12
        return stackViewTrand
    }()
    private lazy var labelTranding: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tranding now"
        label.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.medium)
        
        return label
    }()
    
    private lazy var viewMainBottom: UIView = {
        let viewMainBottom = UIView()
        viewMainBottom.translatesAutoresizingMaskIntoConstraints = false
        viewMainBottom.backgroundColor = .white
        return viewMainBottom
    }()
    private lazy var scrollViewFav:UIScrollView = {
        let scrollViewTrand = UIScrollView()
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsHorizontalScrollIndicator = false
        return $0
    }(UIScrollView())
    
    private lazy var stackViewFav: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 12
        return $0
    }(UIStackView())
    
    private lazy var labelSavedRecipes: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Saved recipes"
        $0.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.medium)
        return $0
    }(UILabel())
    
    init() {
        super.init(frame: CGRect())
        self.backgroundColor = .white
        self.addSubview(stackMain)
        stackMain.addArrangedSubview(viewMainTop)
        stackMain.addArrangedSubview(viewMainMiddle)
        stackMain.addArrangedSubview(viewMainBottom)
        viewMainTop.addSubview(labelMainTitle)
        viewMainMiddle.addSubview(scrollViewTrand)
        addPreviewCards(stackViewTrand, imageWidth: 300)
        scrollViewTrand.addSubview(stackViewTrand)
        viewMainMiddle.addSubview(labelTranding)
        
        viewMainBottom.addSubview(scrollViewFav)
        scrollViewFav.addSubview(stackViewFav)
        addPreviewCards(stackViewFav, imageWidth: 150)
        viewMainBottom.addSubview(labelSavedRecipes)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addPreviewCards(_ toStackView: UIStackView, imageWidth: CGFloat) {
        for _ in 0..<10 {
            let view = PreviewRecipeCard()
            toStackView.addArrangedSubview(view)
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalToConstant: imageWidth),
                view.heightAnchor.constraint(equalTo: toStackView.heightAnchor)
            ])
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            //for stackView
            stackMain.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackMain.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackMain.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            stackMain.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100),
            //for Top View
            viewMainTop.leadingAnchor.constraint(equalTo: stackMain.leadingAnchor),
            viewMainTop.trailingAnchor.constraint(equalTo: stackMain.trailingAnchor),
            viewMainTop.heightAnchor.constraint(equalTo: stackMain.heightAnchor, multiplier: 0.2),
            //title at top
            labelMainTitle.centerYAnchor.constraint(equalTo: viewMainTop.centerYAnchor),
            labelMainTitle.leadingAnchor.constraint(equalTo: viewMainTop.leadingAnchor, constant: 10),
            
            //for Middle View
            viewMainMiddle.leadingAnchor.constraint(equalTo: stackMain.leadingAnchor),
            viewMainMiddle.trailingAnchor.constraint(equalTo: stackMain.trailingAnchor),
            viewMainMiddle.heightAnchor.constraint(equalTo: stackMain.heightAnchor, multiplier: 0.4),
            scrollViewTrand.leadingAnchor.constraint(equalTo: viewMainMiddle.leadingAnchor),
            scrollViewTrand.trailingAnchor.constraint(equalTo: viewMainMiddle.trailingAnchor),
            scrollViewTrand.topAnchor.constraint(equalTo: viewMainMiddle.topAnchor),
            scrollViewTrand.bottomAnchor.constraint(equalTo: viewMainMiddle.bottomAnchor),
            
            stackViewTrand.leadingAnchor.constraint(equalTo: scrollViewTrand.leadingAnchor),
            stackViewTrand.trailingAnchor.constraint(equalTo: scrollViewTrand.trailingAnchor),
            stackViewTrand.bottomAnchor.constraint(equalTo: scrollViewTrand.bottomAnchor),
            stackViewTrand.topAnchor.constraint(equalTo: scrollViewTrand.topAnchor),
            stackViewTrand.heightAnchor.constraint(equalTo: scrollViewTrand.heightAnchor),
            
            labelTranding.topAnchor.constraint(equalTo: viewMainMiddle.topAnchor),
            labelTranding.leadingAnchor.constraint(equalTo: viewMainMiddle.leadingAnchor),
            
            
            //for Bottom View
            viewMainBottom.leadingAnchor.constraint(equalTo: stackMain.leadingAnchor),
            viewMainBottom.trailingAnchor.constraint(equalTo: stackMain.trailingAnchor),
            viewMainMiddle.heightAnchor.constraint(equalTo: stackMain.heightAnchor, multiplier: 0.5),
            
            scrollViewFav.leadingAnchor.constraint(equalTo: viewMainBottom.leadingAnchor),
            scrollViewFav.trailingAnchor.constraint(equalTo: viewMainBottom.trailingAnchor),
            scrollViewFav.topAnchor.constraint(equalTo: viewMainBottom.topAnchor),
            scrollViewFav.bottomAnchor.constraint(equalTo: viewMainBottom.bottomAnchor),
            
            stackViewFav.leadingAnchor.constraint(equalTo: scrollViewFav.leadingAnchor),
            stackViewFav.trailingAnchor.constraint(equalTo: scrollViewFav.trailingAnchor),
            stackViewFav.bottomAnchor.constraint(equalTo: scrollViewFav.bottomAnchor),
            stackViewFav.topAnchor.constraint(equalTo: scrollViewFav.topAnchor),
            stackViewFav.heightAnchor.constraint(equalTo: scrollViewFav.heightAnchor),
            
            labelSavedRecipes.topAnchor.constraint(equalTo: viewMainBottom.topAnchor),
            labelSavedRecipes.leadingAnchor.constraint(equalTo: viewMainBottom.leadingAnchor),
        ])
        
    }
    
    func setPopularRecipes(recipes: [RecipeInfoData]) {
        for item in recipes {
            //ToDo
        }
    }
    
    func setSavedRecipes(recipes: [RecipeInfoData]) {
        for item in recipes {
            //ToDo
        }
    }
}
