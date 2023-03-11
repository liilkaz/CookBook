import UIKit

protocol CategoriesCollectionViewDelegate {
    func pushCategorieList(type: TypeMeal) //toDoStruct
    func getImages(recipeId: Int) ->UIImage //toDoStruct
}

class CategoriesCollectionView: UICollectionView {
    
    private let collectionViewFlowLayout = UICollectionViewFlowLayout()
    private let cellId = "cellId"
    private let cell = CategoriesCollectionViewCell()
    var categorieListDelegat: CategoriesCollectionViewDelegate?
    var mealTypeList: [(TypeMeal, Int)] = []
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        
        configure()
        setupLayout()
        setDelegates()
        register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        collectionViewFlowLayout.minimumLineSpacing = 10
        collectionViewFlowLayout.minimumInteritemSpacing = 0
    }
    
    private func configure() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setDelegates() {
        delegate = self
        dataSource = self
    }
    func setCategoriresTitle(typeMealArray: [(TypeMeal, Int)]) {
        mealTypeList = typeMealArray
    }
}

//MARK: - Extensions
extension CategoriesCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.mealTypeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? CategoriesCollectionViewCell else { return UICollectionViewCell()
        }
        cell.setText(textLabel: mealTypeList[indexPath.row].0.rawValue)
        cell.setImage(image: (categorieListDelegat?.getImages(recipeId: mealTypeList[indexPath.row].1))!)
        return cell
    }
}

extension CategoriesCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        categorieListDelegat?.pushCategorieList(type: mealTypeList[indexPath.row].0)
    }
}

extension CategoriesCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 2,  height: collectionView.frame.height / 7)
    }
}
