//
//  SearchNotStartedView.swift
//  СookBook
//
//  Created by Леонид Егоров on 10.03.2023.
//

import UIKit

class SearchNotFoundView: UIView {
    
    // Чтобы добавить эту вью, её надо сделать самой нижней в иерархии и растянуть на весь экран (для того чтобы текст был по центру экрана)
    
    private let maneLabel: UILabel = {
        let label = UILabel()
        label.text = "We don't have the recipes you're looking for.\n\nTry looking for another 🔎"
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .headline).withSize(30)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(maneLabel)
    }
}

extension SearchNotFoundView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            maneLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            maneLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            maneLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            maneLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -15)
        ])
    }
}
