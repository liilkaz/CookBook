//
//  MainCourseViewController.swift
//  СookBook
//
//  Created by Meddor on 01.03.2023.
//

import UIKit

class MainCourseViewController: UIViewController {
    
    var viewModel = MainCourseViewModel()
    
    let mainLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name:"HelveticaNeue-Bold", size: 30)
        view.textAlignment = .center
        view.tintColor = .black
        view.text = "Main course"
        return view
    }()
    
    var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.id)
        cv.isPagingEnabled = false
        
        return cv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
        view.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
    }
    func setupUi() {
        view.addSubview(mainLabel)
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            mainLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
            mainLabel.heightAnchor.constraint(equalToConstant: 60),
            
            collectionView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor,constant: 8),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        viewModel.delegat = self
        viewModel.fetchURL()
        
    }
    
    
}
extension MainCourseViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.model?.results.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.id, for: indexPath) as! CollectionViewCell
        cell.labelNameFood.text = viewModel.model?.results[indexPath.row].title
        //cell.backImage.image = UIImage(data: (viewModel.model?.results[indexPath.row].image))
        
        cell.backgroundColor = .yellow
        
        return cell
    }
    //Set Edges to sections
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
    }
    
    //sets Size's
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width * 0.92, height: 250)
    }
}
extension MainCourseViewController: MainCourseProtocol {
    func updateMainCourse() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    
}
