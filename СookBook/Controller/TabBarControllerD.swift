//
//  TabBarController.swift
//  СookBook
//
//  Created by ddd on 21.08.2022.
//

import UIKit





class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    
    func createPreviewCard() -> UIView {
        let viewPreviewCard = UIView()
        viewPreviewCard.backgroundColor = .cyan
        viewPreviewCard.frame.size.width = 200
        viewPreviewCard.translatesAutoresizingMaskIntoConstraints = false
        let labelTitleMiddleView = UILabel()
        labelTitleMiddleView.translatesAutoresizingMaskIntoConstraints = false
        labelTitleMiddleView.text = "Trending now"
        labelTitleMiddleView.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.medium)
        
        let imageMeal = UIImageView()
        imageMeal.translatesAutoresizingMaskIntoConstraints = false
        
        let labelDinnerType = UILabel()
        labelDinnerType.translatesAutoresizingMaskIntoConstraints = false
        labelDinnerType.text = "dinner, main dish"
        
        
        
        viewPreviewCard.addSubview(labelTitleMiddleView)
        viewPreviewCard.addSubview(imageMeal)
        viewPreviewCard.addSubview(labelDinnerType)
        
        //constraint
        NSLayoutConstraint.activate([
            labelTitleMiddleView.topAnchor.constraint(equalTo: viewPreviewCard.topAnchor),
            labelTitleMiddleView.leadingAnchor.constraint(equalTo: viewPreviewCard.leadingAnchor, constant: 10),
            imageMeal.leadingAnchor.constraint(equalTo: viewPreviewCard.leadingAnchor),
            imageMeal.trailingAnchor.constraint(equalTo: viewPreviewCard.trailingAnchor),
            imageMeal.topAnchor.constraint(equalTo: viewPreviewCard.topAnchor, constant: 20),
            imageMeal.bottomAnchor.constraint(equalTo: viewPreviewCard.bottomAnchor, constant: 20),
            
            labelDinnerType.leadingAnchor.constraint(equalTo: viewPreviewCard.leadingAnchor),
            labelDinnerType.bottomAnchor.constraint(equalTo: viewPreviewCard.bottomAnchor)
        ])
        
        
        
        return viewPreviewCard
    }
    
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vcMain = UIViewController()
        vcMain.view.backgroundColor = .green
        let stackMain = UIStackView()
        stackMain.translatesAutoresizingMaskIntoConstraints = false
        stackMain.spacing = 5
        stackMain.axis = .vertical
        stackMain.distribution = .fill
        stackMain.backgroundColor = .blue
        let viewMainTop = UIView()
        viewMainTop.translatesAutoresizingMaskIntoConstraints = false
        viewMainTop.backgroundColor = .white
        let labelMainTitle = UILabel()
        labelMainTitle.translatesAutoresizingMaskIntoConstraints = false
        labelMainTitle.text = "Get amazing recipes\nfor cooking"
        labelMainTitle.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.heavy)
        labelMainTitle.backgroundColor = .white
        labelMainTitle.numberOfLines = 0
        
        let viewMainMiddle = UIView()
        viewMainMiddle.translatesAutoresizingMaskIntoConstraints = false
        viewMainMiddle.backgroundColor = .white
        let scrollViewTrand = UIScrollView()
        scrollViewTrand.translatesAutoresizingMaskIntoConstraints = false
        let stackViewTrand = UIStackView()
        stackViewTrand.translatesAutoresizingMaskIntoConstraints = false
        stackViewTrand.backgroundColor = .green
        stackViewTrand.axis = .horizontal
        stackViewTrand.alignment = .fill
        stackViewTrand.distribution = .fillEqually
        stackViewTrand.spacing = 12
        
        
        //add PreviewCard
        let card1 = createPreviewCard()
        let card2 = createPreviewCard()
        let card3 = createPreviewCard()
        let card4 = createPreviewCard()
        let card5 = createPreviewCard()
        
        
        
        let viewMainBottom = UIView()
        viewMainBottom.translatesAutoresizingMaskIntoConstraints = false
        viewMainBottom.backgroundColor = .white
        
        vcMain.view.addSubview(stackMain)
        stackMain.addArrangedSubview(viewMainTop)
        stackMain.addArrangedSubview(viewMainMiddle)
        stackMain.addArrangedSubview(viewMainBottom)
        
        viewMainTop.addSubview(labelMainTitle)
        
        viewMainMiddle.addSubview(scrollViewTrand)
        scrollViewTrand.addSubview(stackViewTrand)
        stackViewTrand.addArrangedSubview(card1)
        stackViewTrand.addArrangedSubview(card2)
        stackViewTrand.addArrangedSubview(card3)
        stackViewTrand.addArrangedSubview(card4)
        stackViewTrand.addArrangedSubview(card5)
        
        
        
        //constraint
        NSLayoutConstraint.activate([
            //for stackView
            stackMain.leadingAnchor.constraint(equalTo: vcMain.view.leadingAnchor),
            stackMain.trailingAnchor.constraint(equalTo: vcMain.view.trailingAnchor),
            stackMain.topAnchor.constraint(equalTo: vcMain.view.topAnchor, constant: 90),
            stackMain.bottomAnchor.constraint(equalTo: vcMain.view.bottomAnchor),
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
            stackViewTrand.widthAnchor.constraint(equalTo: scrollViewTrand.widthAnchor),
            
            
            
            //for Bottom View
            viewMainBottom.leadingAnchor.constraint(equalTo: stackMain.leadingAnchor),
            viewMainBottom.trailingAnchor.constraint(equalTo: stackMain.trailingAnchor),
           
        ])
        
        let vcFavourite = UIViewController()
        vcFavourite.view.backgroundColor = .yellow
      
        let vcSearch = UIViewController()
        vcSearch.view.backgroundColor = .red
        
        let navController1 = UINavigationController()
        navController1.viewControllers = [vcMain]
        navController1.tabBarItem.title = "Main"
        navController1.tabBarItem.image = UIImage(systemName: "house")
        navController1.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        
        let navController2 = UINavigationController(rootViewController: vcFavourite)
        navController2.tabBarItem.title = "Favourite"
        navController2.tabBarItem.image = UIImage(systemName: "star")
        navController2.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
        
        let navController3 = UINavigationController(rootViewController: vcSearch)
        navController3.tabBarItem.title = "Search"
        navController3.tabBarItem.image = UIImage(systemName: "magnifyingglass.circle")
        navController3.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass.circle.fill")
        
        viewControllers = [navController1, navController2, navController3 ]
 
    }
    

    

}
