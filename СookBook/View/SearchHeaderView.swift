//
//  SearchHeaderView.swift
//  СookBook
//
//  Created by Vladimir V. on 02.03.2023.
//

import UIKit

final class SearchHeaderView: UIView {
    
    let hStack: UIStackView = {
        $0.axis = .horizontal
        //$0.distribution = .fillEqually
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = 10
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    } (UIStackView())
    
    let searchField: UITextField = {
        $0.backgroundColor = .red
        $0.textAlignment = .right
        $0.placeholder = "Search"
        return $0
    }(UITextField())
    
    let searchButton: UIButton = {
        $0.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        $0.tintColor = .white
        //$0.setImage(UIImage(named: "magnifyingglass"), for: .normal)
        $0.contentVerticalAlignment = .center
        $0.contentHorizontalAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        self.addSubview(hStack)
        hStack.addArrangedSubview(searchField)
        hStack.addArrangedSubview(searchButton)
        setConstrains()
    }
    
    func setConstrains() {
        NSLayoutConstraint.activate([
            hStack.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 0),
            hStack.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: 0),
            hStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            
            searchButton.widthAnchor.constraint(equalToConstant: 40),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
}
