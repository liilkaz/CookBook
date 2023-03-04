//
//  ListResipeCollectionViewCell.swift
//  СookBook
//
//  Created by Meddor on 02.03.2023.
//

import UIKit

class ListResipeCollectionViewCell: UICollectionViewCell {
    
    
    static let id = "CellId"
    
    let backImage: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .brown
        return view
    }()
    let labelNameFood: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name:"HelveticaNeue-Bold", size: 22)
        view.textAlignment = .left
        view.tintColor = .white
        view.text = "Плов Узбекский с бараниной"
        view.numberOfLines = 0
        return view
    }()
    let labelDescription: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name:"HelveticaNeue-Bold", size: 17)
        view.textAlignment = .left
        view.tintColor = .white
        view.text = "9 ingridients  |  25 min"
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUi()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUi() {
        contentView.addSubview(backImage)
        contentView.addSubview(labelNameFood)
        contentView.addSubview(labelDescription)
        NSLayoutConstraint.activate([
            backImage.topAnchor.constraint(equalTo:  contentView.topAnchor),
            backImage.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            backImage.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            backImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            labelNameFood.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 130),
            labelNameFood.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 20),
            labelNameFood.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -50),
            
            labelDescription.topAnchor.constraint(equalTo: labelNameFood.bottomAnchor,constant: 10),
            labelDescription.leftAnchor.constraint(equalTo: labelNameFood.leftAnchor),
            
        ])
    }
}


