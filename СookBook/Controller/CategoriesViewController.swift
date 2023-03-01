import UIKit

class CategoriesViewController: UIViewController {
    
    private let categoriesLabelAndImageView = CategoriesLabelAndImageView()
    private let categoriesCollectionView = CategoriesCollectionView()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(categoriesLabelAndImageView)
        view.addSubview(categoriesCollectionView)
    }
}

extension CategoriesViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            categoriesLabelAndImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            categoriesLabelAndImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoriesLabelAndImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            categoriesLabelAndImageView.heightAnchor.constraint(equalToConstant: 100),
            
            categoriesCollectionView.topAnchor.constraint(equalTo: categoriesLabelAndImageView.bottomAnchor),
            categoriesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoriesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
