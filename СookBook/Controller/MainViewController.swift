//
//  ViewController.swift
//  СookBook
//
//  Created by Лилия Феодотова on 26.02.2023.
//

import UIKit

fileprivate let GALLERY_SECTION: [Int] = [1, 3]
fileprivate let TEXT_SECTION: [Int] = [0, 2]
fileprivate let LIST_SECTION: [Int] = []

class MainViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    var coordinator: Coordinator?
    var arrayItems:[Int] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if GALLERY_SECTION.contains(section) {
            return arrayItems.count
        }
        if TEXT_SECTION.contains(section) {
            return 1
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

//        }
        
        if indexPath.section == 1 {
            let recipeInfoData = coordinator?.getRecipe(arrayItems[indexPath.row])
            let cell = CellBuilder.getTrendingCell(viewDelegate: self,
                                                   collectionView: collectionView,
                                                   indexPath: indexPath,
                                                   recipeInfoData: recipeInfoData as Any,
                                                   recipeImage: coordinator?.getImage(recipeInfoData!.id) as Any)
    //        if let vc = (viewController as? UINavigationController)  {
            return cell
        }
        if indexPath.section == 3 {
            let recipeInfoData = coordinator?.getRecipe(arrayItems[indexPath.row])
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
        return UICollectionViewCell()
        //return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipeId = arrayItems[indexPath.row]
        let recipe = coordinator?.getRecipe(recipeId)
        coordinator?.eventOccurred(with: .recipeTapped, recipe: recipe!)
    }
    
    lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.makeLayout())
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        //collectionView.register(Cell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(RecipeCollectionViewCell.self, forCellWithReuseIdentifier: "recipe")
        collectionView.register(Text.self, forCellWithReuseIdentifier: "text")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            if GALLERY_SECTION.contains(section) {
                if section == 1 {
                    return LayoutBuilder.buildTrendingSectionLayout(size: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.32)))
                }
                return LayoutBuilder.buildTrendingSectionLayout(size: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.45), heightDimension: .fractionalHeight(0.25)))
            } else if TEXT_SECTION.contains(section) {
                return LayoutBuilder.buildTextSectionLayout()
            } else {
               //return LayoutBuilder.buildTableSectionLayout()
            }
            return LayoutBuilder.buildTextSectionLayout()
        }
        return layout
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayItems = (coordinator?.cookManager?.cookData.favoriteRecipes)!
        // Do any additional setup after loading the view.
        self.view.addSubview(self.collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        didUpdateView()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return GALLERY_SECTION.count + TEXT_SECTION.count
    }


}
extension MainViewController: Coordinating {
    
    func didUpdateView() {
        self.arrayItems = (coordinator?.cookManager?.cookData.favoriteRecipes)!
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
