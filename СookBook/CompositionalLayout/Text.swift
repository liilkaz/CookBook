//
//  Text.swift
//  CompositionalLayout
//
//  Created by Vladimir V. on 07.03.2023.
//

import UIKit

public class Text: UICollectionViewCell {
    static let withSize = 25.0
    
     var container: UIView = {
         let view = UIView()
         view.backgroundColor = UIColor.white
         view.translatesAutoresizingMaskIntoConstraints = false
         return view
     }()
     
     var text: UILabel = {
         let label: UILabel = UILabel()
         label.text = "History recipes"
         label.numberOfLines = 0
         label.translatesAutoresizingMaskIntoConstraints = false
         label.font = UIFont.preferredFont(forTextStyle: .headline).withSize(Text.withSize)
         return label
     }()

     override init(frame: CGRect) {
         super.init(frame: frame)
         self.contentView.addSubview(self.container)
         self.container.addSubview(self.text)
         
         NSLayoutConstraint.activate([
             self.container.topAnchor.constraint(equalTo: self.contentView.topAnchor),
             self.container.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
             self.container.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
             self.container.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
         ])
         
         NSLayoutConstraint.activate([
             self.text.topAnchor.constraint(equalTo: self.container.topAnchor),
             self.text.leftAnchor.constraint(equalTo: self.container.leftAnchor),
             self.text.bottomAnchor.constraint(equalTo: self.container.bottomAnchor),
             self.text.rightAnchor.constraint(equalTo: self.container.rightAnchor)
         ])
     }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
 }

public class TrendText: UICollectionViewCell {
     var container: UIView = {
         let view = UIView()
         view.backgroundColor = UIColor.white
         view.translatesAutoresizingMaskIntoConstraints = false
         return view
     }()
     
     var text: UILabel = {
         let label: UILabel = UILabel()
         label.text = "Trending now"
         label.numberOfLines = 0
         label.translatesAutoresizingMaskIntoConstraints = false
         label.font = UIFont.preferredFont(forTextStyle: .headline).withSize(Text.withSize)
         return label
     }()

     override init(frame: CGRect) {
         super.init(frame: frame)
         self.contentView.addSubview(self.container)
         self.container.addSubview(self.text)
         
         NSLayoutConstraint.activate([
             self.container.topAnchor.constraint(equalTo: self.contentView.topAnchor),
             self.container.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
             self.container.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
             self.container.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
         ])
         
         NSLayoutConstraint.activate([
             self.text.topAnchor.constraint(equalTo: self.container.topAnchor),
             self.text.leftAnchor.constraint(equalTo: self.container.leftAnchor),
             self.text.bottomAnchor.constraint(equalTo: self.container.bottomAnchor),
             self.text.rightAnchor.constraint(equalTo: self.container.rightAnchor)
         ])
     }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
 }

