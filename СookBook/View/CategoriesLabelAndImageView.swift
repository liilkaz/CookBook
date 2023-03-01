import UIKit

class CategoriesLabelAndImageView: UIView {
    
    private let categoriesLabelImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "CategoriesLabelImage")
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let categoriesLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular categories"
        label.textColor = .black
        label.font = .systemFont(ofSize: 28, weight: .bold)
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
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(categoriesLabelImage)
        addSubview(categoriesLabel)
    }
}

extension CategoriesLabelAndImageView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            categoriesLabelImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            categoriesLabelImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            categoriesLabelImage.heightAnchor.constraint(equalToConstant: 94),
            categoriesLabelImage.widthAnchor.constraint(equalToConstant: 94),
            
            categoriesLabel.centerYAnchor.constraint(equalTo: categoriesLabelImage.centerYAnchor),
            categoriesLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoriesLabel.trailingAnchor.constraint(equalTo: categoriesLabelImage.leadingAnchor, constant: -10)
        ])
    }
}
