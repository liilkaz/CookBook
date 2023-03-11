//
//  ViewController.swift
//  СookBook
//
//  Created by Лилия Феодотова on 26.02.2023.
//

import UIKit

fileprivate let GALLERY_SECTION: [Int] = [1, 3]
fileprivate let TEXT_SECTION: [Int] = [2]
fileprivate let TREND_TEXT_SECTION: [Int] = [0]
fileprivate let LIST_SECTION: [Int] = []

class MainViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    var coordinator: Coordinator?
    var trendItems:[Int] = []
    var historyItems:[Int] = []
    
    let headerText: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Get amazing recipes for cooking"
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .headline).withSize(30)
        return label
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return trendItems.count
        }
        if section == 3 {
            return historyItems.count
        }

        if TEXT_SECTION.contains(section) {
            return 1
        }
        if TREND_TEXT_SECTION.contains(section) {
            return 1
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.section == 1 {
            let recipeInfoData = coordinator?.getRecipe(self.trendItems[indexPath.row])
            let cell = CellBuilder.getTrendingCell(viewDelegate: self,
                                                   collectionView: collectionView,
                                                   indexPath: indexPath,
                                                   recipeInfoData: recipeInfoData as Any,
                                                   recipeImage: coordinator?.getImage(recipeInfoData!.id) as Any)
    //        if let vc = (viewController as? UINavigationController)  {
            return cell
        }
        if indexPath.section == 3 {
            let recipeInfoData = coordinator?.getRecipe(self.historyItems[indexPath.row])
            let cell = CellBuilder.getLastRecipeCell(viewDelegate: self,
                                                   collectionView: collectionView,
                                                   indexPath: indexPath,
                                                   recipeInfoData: recipeInfoData as Any,
                                                   recipeImage: coordinator?.getImage(recipeInfoData!.id) as Any)
    //        if let vc = (viewController as? UINavigationController)  {
            return cell
        }
        if TEXT_SECTION.contains(indexPath.section) {
            return CellBuilder.getTextCell(collectionView: collectionView, indexPath: indexPath)
        }
        if TREND_TEXT_SECTION.contains(indexPath.section) {
            return CellBuilder.getTrendTextCell(collectionView: collectionView, indexPath: indexPath)
        }
        
        return UICollectionViewCell()
        //return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let recipeId = self.trendItems[indexPath.row]
            let recipe = coordinator?.getRecipe(recipeId)
            coordinator?.eventOccurred(with: .recipeTapped, recipe: recipe!)
        } else
        if indexPath.section == 3 {
            let recipeId = self.historyItems[indexPath.row]
            let recipe = coordinator?.getRecipe(recipeId)
            coordinator?.eventOccurred(with: .recipeTapped, recipe: recipe!)
        }

    }
    
    lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.makeLayout())
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        //collectionView.register(Cell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(TranderRecipeCollectionViewCell.self, forCellWithReuseIdentifier: "trendRecipe")
        collectionView.register(LastWatchRecipeCollectionViewCell.self, forCellWithReuseIdentifier: "lastWatchRecipe")
        collectionView.register(Text.self, forCellWithReuseIdentifier: "text")
        collectionView.register(TrendText.self, forCellWithReuseIdentifier: "trendText")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            if GALLERY_SECTION.contains(section) {
                if section == 1 {
                    return LayoutBuilder.buildRecipeSectionLayout(size: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.45)))
                }
                return LayoutBuilder.buildRecipeSectionLayout(size: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.45), heightDimension: .fractionalHeight(0.32)))
            }
            if TEXT_SECTION.contains(section) {
                return LayoutBuilder.buildTextSectionLayout()
            }
            if TREND_TEXT_SECTION.contains(section) {
                return LayoutBuilder.buildTextSectionLayout()
            }
            
            return LayoutBuilder.buildTextSectionLayout()
        }
        return layout
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        trendItems = (coordinator?.cookManager?.cookData.popularRecipes)!
        historyItems = (coordinator?.cookManager?.cookData.historyRecipes)!
        // Do any additional setup after loading the view.
        self.view.addSubview(self.headerText)
        self.view.addSubview(self.collectionView)
        
        NSLayoutConstraint.activate([
            self.headerText.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.headerText.heightAnchor.constraint(equalToConstant: 77.0),
            self.headerText.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15),
            self.headerText.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.headerText.bottomAnchor, constant: 5),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 5)
        ])
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        didUpdateView()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return GALLERY_SECTION.count + TEXT_SECTION.count + TREND_TEXT_SECTION.count
    }


}
extension MainViewController: Coordinating {
    
    func didUpdateView() {
        self.trendItems = (coordinator?.cookManager?.cookData.popularRecipes)!
        self.historyItems = (coordinator?.cookManager?.cookData.historyRecipes)!
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func didUpdateImage(recipeId: Int) {
        print(recipeId)
    }
}

extension MainViewController: RecipeViewDelegate {
    func pushCheckFavorite(recipe: RecipeInfoData) {
        coordinator?.eventOccurred(with: .favoriteTapped, recipe: recipe)
    }
}
