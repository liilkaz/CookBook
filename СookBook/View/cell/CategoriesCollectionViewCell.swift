import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "CategoriesMieAyam")
        imageView.image = image?.withHorizontallyFlippedOrientation()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let categoriesLabel: UILabel = {
        let label = UILabel()
        label.text = "MieAyam"
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
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
    
    func setupViews() {
        addSubview(backgroundImage)
        contentView.addSubview(categoriesLabel)
    }
    
    func setText(textLabel: String) {
        categoriesLabel.text = textLabel
    }
}

extension CategoriesCollectionViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor, constant:0),
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            categoriesLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            categoriesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
    }
}
