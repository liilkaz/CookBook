//
//  RecipeViewController.swift
//  СookBook
//
//  Created by Лилия Феодотова on 26.02.2023.
//
//
import UIKit


final class RecipeViewController: UIViewController , RecipeViewDelegate, Coordinating {
    
    let tagsListString = ["240 calories","40 min","Easy","serves 2"]
    var coordinator: Coordinator?
    var recipeInfo: RecipeInfoData = RecipeInfoData(from: RecipeData(id: 1, title: "Hello", image: "", imageType: ""))
    var recipeImage = InfoRecipeView()
    var amountOfIngridients = 0
    let line = UIView()
    var isTappedCheckButton = false
    
    let scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIScrollView())
    
    let mainStack: UIStackView = {
        $0.axis = .vertical
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    let recipeIngerdientStack: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 5
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    let tagsStack: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 5
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    let titleLabel: UILabel = {
        $0.text = "How to make tasty fish (point & kill)"
        $0.font = .systemFont(ofSize: 24)
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.contentMode = .scaleAspectFit
        $0.textColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        recipeImage.translatesAutoresizingMaskIntoConstraints = false
        createLabels()
        setupConstraints()
        createCellsIngridientsInfo()
        
        recipeImage.recipeViewDelegate = self
        self.didUpdateView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        amountOfIngridients = recipeInfo.extendedIngredients.count
        recipeIngerdientStack.heightAnchor.constraint(equalToConstant: CGFloat(amountOfIngridients*40)).isActive = true
        self.didUpdateView()
    }
    func createLabels(){
        for tagString in tagsListString{
            let tagView = createTagLabelView(tagString)
            tagsStack.addArrangedSubview(tagView)
        }
    }
    func createTagLabelView(_ tag: String) -> UIView{
        let tagLabel = UILabel()
        tagLabel.text = "\(tag)"
        tagLabel.textAlignment = .center
        tagLabel.font = .systemFont(ofSize: 12)
        tagLabel.textColor = .black
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        tagLabel.numberOfLines = 0
        tagLabel.contentMode = .scaleAspectFill
        return tagLabel
    }
    func createCellsIngridientsInfo(){
        for index in 0..<(recipeInfo.extendedIngredients.count){
            let cell = createOneCellView(index)
            recipeIngerdientStack.addArrangedSubview(cell)
        }
    }
    func createOneCellView(_ index: Int) -> UIView {
        let cell = UIStackView()
        let ingridientLabel = UILabel()
        let ingridientAmountLabel = UILabel()
        ingridientLabel.textColor = .black
        ingridientLabel.translatesAutoresizingMaskIntoConstraints = false
        ingridientLabel.numberOfLines = 0
        ingridientLabel.textAlignment = .left
        ingridientAmountLabel.numberOfLines = 0
        ingridientAmountLabel.textColor = .black
        ingridientAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        ingridientAmountLabel.textAlignment = .right
        cell.addArrangedSubview(ingridientLabel)
        cell.addArrangedSubview(ingridientAmountLabel)
        ingridientLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: cell.leadingAnchor, multiplier: 4).isActive = true
        let checkButton = createCheckButton()
        cell.addSubview(checkButton)
        checkButton.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
        checkButton.trailingAnchor.constraint(equalTo: ingridientLabel.leadingAnchor).isActive = true
        checkButton.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        return cell
    }
    func createCheckButton() -> UIButton{
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.addTarget(self, action: #selector(changeImageCheckButton(sender:)), for: .touchUpInside)
        return button
    }
    @objc
    private func changeImageCheckButton(sender: UIButton){
        if(isTappedCheckButton){
            sender.setImage(UIImage(systemName: "circle"), for: .normal)
            isTappedCheckButton = false
        } else {
            sender.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            isTappedCheckButton = true
        }
    }
    func didUpdateView() {
        recipeInfo = (coordinator?.getRecipe(recipeInfo.id))!
        titleLabel.text = recipeInfo.title
        recipeImage.updateImage(image: (coordinator?.getImage(recipeInfo.id))!)
        recipeImage.reloadRecipe(recipe: recipeInfo)
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    func reloadData(){
        for index in 0..<(recipeInfo.extendedIngredients.count){
            let cell = (recipeIngerdientStack.arrangedSubviews[index] as! UIStackView)
            let ingridientLabel = (cell.arrangedSubviews[0] as! UILabel)
            let ingridientAmountLabel = (cell.arrangedSubviews[1] as! UILabel)
            ingridientLabel.text = "\(recipeInfo.extendedIngredients[index].nameClean)"
            ingridientAmountLabel.text = "\((recipeInfo.extendedIngredients[index].amount))  \((recipeInfo.extendedIngredients[index].unit))"
        }
    }
    
    func didUpdateImage(recipeId: Int) {
        recipeImage.updateImage(image: (coordinator?.getImage(recipeId))!)
    }
    
    func pushCheckFavorite(recipe: RecipeInfoData) {
        coordinator?.eventOccurred(with: .favoriteTapped, recipe: recipe)
    }
}

//MARK: setting up constaraints
extension RecipeViewController{
    func setupConstraints(){
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        scrollView.addSubview(mainStack)
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainStack.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            mainStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            mainStack.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.90),
            mainStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2)
        ])
        mainStack.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: mainStack.topAnchor,constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalToSystemSpacingAfter: mainStack.trailingAnchor, multiplier: -2)
        ])
        mainStack.addSubview(tagsStack)
        NSLayoutConstraint.activate([
            tagsStack.heightAnchor.constraint(equalToConstant: 20),
            tagsStack.topAnchor.constraint(equalToSystemSpacingBelow: mainStack.topAnchor, multiplier: 40),
            tagsStack.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
            tagsStack.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor)
        ])
        mainStack.addSubview(recipeImage)
        NSLayoutConstraint.activate([
            recipeImage.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1),
            recipeImage.bottomAnchor.constraint(equalTo: tagsStack.topAnchor),
            recipeImage.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
            recipeImage.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
        ])
        mainStack.addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.widthAnchor.constraint(equalToConstant: view.bounds.width - 40).isActive = true
        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
        line.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        line.topAnchor.constraint(equalTo: tagsStack.bottomAnchor,constant: 20).isActive = true
        line.backgroundColor = .gray
        mainStack.addSubview(recipeIngerdientStack)
        NSLayoutConstraint.activate([
            recipeIngerdientStack.topAnchor.constraint(equalToSystemSpacingBelow: line.bottomAnchor, multiplier: 1),
            recipeIngerdientStack.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
            recipeIngerdientStack.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
        ])
    }
}
