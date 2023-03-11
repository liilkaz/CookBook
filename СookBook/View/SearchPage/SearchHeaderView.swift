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
        $0.distribution = .fillEqually
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = 10
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    } (UIStackView())
    
    let searchField: UITextField = {
        let textField = UITextField()
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.textColor = .gray
        textField.isHidden = false
        textField.backgroundColor = .systemFill
        textField.placeholder = "Search"
        textField.minimumFontSize = 12
        textField.tintColor = .gray
        textField.layer.cornerRadius = 10
        textField.borderStyle = .roundedRect
        
        textField.font = .systemFont(ofSize: 20)
        textField.textAlignment = .left
        textField.contentMode = .scaleToFill
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let searchButton: UIButton = {
        $0.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        $0.tintColor = .lightGray
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
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstrains() {
        NSLayoutConstraint.activate([
            hStack.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10),
            hStack.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 0),
            hStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            
            searchButton.widthAnchor.constraint(equalToConstant: 40),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
