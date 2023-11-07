//
//  AdsTableViewCell.swift
//  PetFinder
//
//  Created by Алексей Шамрей on 21.10.23.
//

import UIKit
import SnapKit

class AdsTableViewCell: UITableViewCell {
        
    private lazy var petSignsLabelStack: UIStackView = {
        let petSignsLabelStack = UIStackView()
        petSignsLabelStack.distribution = .fill
        petSignsLabelStack.spacing = 4
        petSignsLabelStack.axis = .vertical
        return petSignsLabelStack
    }()
    
    private lazy var favorites: UIButton = {
        let favorites = UIButton()
        favorites.setImage(UIImage(named: "star"), for: .normal)
        favorites.addTarget(self, action: #selector(favoritesButtonTapped), for: .touchUpInside)
        favorites.imageView?.layer.shadowColor = UIColor.black.cgColor
        favorites.imageView?.layer.shadowOpacity = 0.5
        favorites.imageView?.layer.shadowOffset = CGSize(width: 1, height: 1)
        favorites.imageView?.layer.shadowRadius = 1


        return favorites
    }()

    private lazy var currentPossitionAd: UIButton = {
        let currentPossitionAd = UIButton()
        currentPossitionAd.setTitle(" 1.5км от Вас", for: .normal)
        currentPossitionAd.titleLabel?.font = UIFont.sfProText(ofSize: 12, weight: .regular)
        currentPossitionAd.setTitleColor(.black, for: .normal)
        currentPossitionAd.titleLabel?.numberOfLines = 1
        
        let image = UIImage(named: "mapPoint")
        let resizedImage = image?.resized(toSize: CGSize(width: 18, height: 20))
        
        currentPossitionAd.setImage(resizedImage, for: .normal)
        
        return currentPossitionAd
    }()
    
    private lazy var imagePet: UIImageView = {
        let imagePet = UIImageView()
        imagePet.clipsToBounds = true

        let image = UIImage(named: "dog_back")
        imagePet.image = image
        imagePet.contentMode = .scaleToFill
        imagePet.backgroundColor = .clear
        imagePet.layer.cornerRadius = 24
        return imagePet
    }()
    
    private lazy var typeAdStack : UIStackView = {
        let typeAdStack = UIStackView()
        typeAdStack.distribution = .fill
        typeAdStack.spacing = 2
        typeAdStack.axis = .vertical
        typeAdStack.alignment = .center
        return typeAdStack
    }()
    
    private lazy var typeAd: UIImageView = {
        let typeAd = UIImageView()
        let image = UIImage(named: "lost_image")
        typeAd.image = image
        typeAd.contentMode = .scaleAspectFill
        typeAd.clipsToBounds = true
        return typeAd
    }()

    
    private lazy var typeAdText: UILabel = {
        let typeAdText = UILabel()
        typeAdText.font = UIFont.sfProText(ofSize: 12, weight: .light)
        typeAdText.text = "Потерян"
        typeAdText.textColor = .black
        typeAdText.numberOfLines = 0
        return typeAdText
    }()
    
    private lazy var mainView: UIView = {
        let mainView = UIView()
        mainView.layer.cornerRadius = 12
        mainView.backgroundColor = UIColor(hex: 0xFDF5F0, alpha: 1)
//        mainView.backgroundColor = .gray
        return mainView
    }()
    
    private lazy var insertView: UIView = {
        let insertView = UIView()
        insertView.backgroundColor = .clear
        return insertView
    }()
    
    private lazy var labelAd: UILabel = {
        let labelAd = UILabel()
        labelAd.font = UIFont.sfProText(ofSize: 20, weight: .semiBold)
        labelAd.textColor = .black
        labelAd.lineBreakMode = .byTruncatingTail
        labelAd.numberOfLines = 0
        return labelAd
    }()

    private lazy var dateCreation: UILabel = {
        let dateCreation = UILabel()
        dateCreation.font = UIFont.sfProText(ofSize: 12, weight: .light)
        dateCreation.textColor = .black
        dateCreation.numberOfLines = 0
        dateCreation.text = "Вчера, 21:35"
        return dateCreation
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func createUI(text: String, data: [String]) {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        labelAd.text = text
        setup()
        createTypeAdStack()
        createPetSingsStack(data: data)
        makeConstraints()
    }
    
    func createTypeAdStack() {
        typeAdStack.addArrangedSubview(typeAd)
        typeAdStack.addArrangedSubview(typeAdText)
        
        mainView.addSubview(typeAdStack)
    }
    
    func setup() {
        self.addSubview(mainView)
        self.addSubview(insertView)
        mainView.addSubview(labelAd)
        mainView.addSubview(dateCreation)
        mainView.addSubview(imagePet)
        mainView.addSubview(typeAd)
        mainView.addSubview(typeAdText)
        mainView.addSubview(typeAdStack)
        mainView.addSubview(petSignsLabelStack)
        mainView.addSubview(currentPossitionAd)
        mainView.addSubview(favorites)
    }

    func createPetSingsStack(data: [String]) {
        petSignsLabelStack.addArrangedSubview(createStackView(firsLabel: "Порода: ", secondLabel: data[0]))
        petSignsLabelStack.addArrangedSubview(createStackView(firsLabel: "Окрас: ", secondLabel: data[1]))
        petSignsLabelStack.addArrangedSubview(createStackView(firsLabel: "Пол: ", secondLabel: data[2]))
        petSignsLabelStack.addArrangedSubview(createStackView(firsLabel: "Возраст: ", secondLabel: data[2]))
    }
    
    func createStackView(firsLabel: String, secondLabel: String) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(createStaticklabel(text: firsLabel, font: UIFont.sfProText(ofSize: 12, weight: .light), color: UIColor(hex: 0xD1713D, alpha: 1)))
        stackView.addArrangedSubview(createStaticklabel(text: secondLabel, font: UIFont.sfProText(ofSize: 14, weight: .light), color: UIColor(hex: 0x250404, alpha: 1)))
        
        return stackView
    }
    
    
    func createStaticklabel(text: String, font: UIFont, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textAlignment = .left
        label.textColor = color
        return label
    }

    func makeConstraints() {
        
        insertView.snp.makeConstraints { maker in
            maker.left.right.bottom.equalToSuperview()
            maker.height.equalTo(24)
        }
      
        mainView.snp.makeConstraints { maker in
            maker.left.right.top.equalToSuperview()
            maker.bottom.equalTo(insertView.snp.top).inset(0)
        }
        
        labelAd.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(14)
            maker.left.equalToSuperview().inset(16)
            maker.right.equalToSuperview().inset(72)
            maker.height.equalTo(22)
        }
        
        typeAd.snp.makeConstraints { maker in
            maker.height.width.equalTo(24)
        }
        
        typeAdStack.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(14)
            maker.right.equalToSuperview().inset(15)
        }

        dateCreation.snp.makeConstraints { maker in
            maker.top.equalTo(labelAd.snp.bottom).inset(-4)
            maker.left.equalToSuperview().inset(16)
            maker.height.equalTo(14)
            
        }
        
        imagePet.snp.makeConstraints { maker in
            maker.top.equalTo(dateCreation.snp.bottom).inset(-12)
            maker.left.equalToSuperview().inset(16)
            maker.bottom.equalToSuperview().inset(16)
            maker.width.equalTo(136)
            maker.height.equalTo(116)
        }
        
        petSignsLabelStack.snp.makeConstraints { maker in
            maker.top.equalTo(dateCreation.snp.bottom).inset(-12)
            maker.left.equalTo(imagePet.snp.right).inset(-16)
            maker.right.equalToSuperview().inset(15)
        }
        
        currentPossitionAd.snp.makeConstraints { maker in
            maker.top.equalTo(petSignsLabelStack.snp.bottom).inset(-10)
            maker.left.equalTo(imagePet.snp.right).inset(-16)
            maker.bottom.equalToSuperview().inset(16)
        }
        
        favorites.snp.makeConstraints { maker in
            maker.top.equalTo(petSignsLabelStack.snp.bottom).inset(-10)
            maker.right.equalToSuperview().inset(15)
            maker.bottom.equalToSuperview().inset(17)
            maker.height.width.equalTo(24)
        }
    }
    
    @objc private func favoritesButtonTapped(sender: UIButton) {
        if let image = sender.imageView?.image, image == UIImage(named: "star") {
            let tintedImage = image.withTintColor(UIColor(hex: 0xFF9900, alpha: 1), renderingMode: .alwaysOriginal)
            sender.setImage(tintedImage, for: .normal)
        } else {
            sender.setImage(UIImage(named: "star"), for: .normal)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
