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

        return favorites
    }()

    private lazy var currentPossitionAd: UIButton = {
        let currentPossitionAd = UIButton()
        currentPossitionAd.setTitle(" 1.5км от Вас", for: .normal)
        currentPossitionAd.titleLabel?.font = UIFont.sfProText(ofSize: 12, weight: .regular)
        currentPossitionAd.setTitleColor(.black, for: .normal)
        currentPossitionAd.titleLabel?.numberOfLines = 1
        
        let image = UIImage(named: "mapPoint")
        let resizedImage = image?.resized(toSize: CGSize(width: 15, height: 18))
        
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
        typeAdStack.spacing = -8
        typeAdStack.axis = .vertical
        typeAdStack.alignment = .center
        return typeAdStack
    }()
    
    private lazy var typeAd: UIImageView = {
        let typeAd = UIImageView()
        let image = UIImage(named: "lost_image")
        typeAd.image = image
        typeAd.contentMode = .scaleToFill
        typeAd.backgroundColor = .clear
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
        mainView.layer.cornerRadius = 20
        mainView.backgroundColor = UIColor(hex: 0xFDF5F0, alpha: 1)
//        mainView.backgroundColor = .red
        return mainView
    }()
    
    private lazy var insertView: UIView = {
        let insertView = UIView()
        insertView.backgroundColor = .clear
        return insertView
    }()
    
    private lazy var labelAd: UILabel = {
        let labelText = UILabel()
        labelText.font = UIFont.sfProText(ofSize: 20, weight: .semiBold)
        labelText.textColor = .black
        labelText.numberOfLines = 0
        return labelText
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
        labelAd.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(12)
            maker.left.equalToSuperview().inset(16)
        }
        
        dateCreation.snp.makeConstraints { maker in
            maker.top.equalTo(labelAd.snp.bottom).inset(7)
            maker.left.equalToSuperview().inset(16)
            
        }
        
        imagePet.snp.makeConstraints { maker in
            maker.top.equalTo(dateCreation.snp.bottom).inset(-12)
            maker.left.equalToSuperview().inset(16)
            maker.width.equalTo(136)
            maker.height.equalTo(116)
            maker.bottom.equalToSuperview().inset(10)
        }
         
        insertView.snp.makeConstraints { maker in
            maker.left.right.bottom.equalToSuperview()
            maker.height.equalTo(10)
        }
      
        mainView.snp.makeConstraints { maker in
            maker.left.right.top.equalToSuperview().inset(15)
            maker.bottom.equalTo(insertView.snp.top).inset(-5)
        }
        
        typeAd.snp.makeConstraints { maker in
            maker.height.width.equalTo(35)
        }
        
        typeAdStack.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(25)
            maker.right.equalToSuperview().inset(15)
        }
        
        petSignsLabelStack.snp.makeConstraints { maker in
            maker.top.equalTo(dateCreation.snp.bottom).inset(-12)
            maker.left.equalTo(imagePet.snp.right).inset(-16)
            maker.right.equalToSuperview().inset(46)
        }
        
        currentPossitionAd.snp.makeConstraints { maker in
            maker.top.equalTo(petSignsLabelStack.snp.bottom).inset(-18)
            maker.left.equalTo(imagePet.snp.right).inset(-16)
            maker.bottom.equalToSuperview().inset(16)
        }
        
        favorites.snp.makeConstraints { maker in
            maker.top.equalTo(petSignsLabelStack.snp.bottom).inset(-10)
            maker.right.equalToSuperview().inset(15)
            maker.height.width.equalTo(48)
        }
        
    }
    
    @objc private func favoritesButtonTapped(sender: UIButton) {
        if sender.currentTitleColor != UIColor(hex: 0xFF9900, alpha: 1) {
            sender.setTitleColor(UIColor(hex: 0xFF9900, alpha: 1), for: .normal)
            if let image = sender.imageView?.image {
                let tintedImage = image.withTintColor(UIColor(hex: 0xFF9900, alpha: 1), renderingMode: .alwaysOriginal)
                sender.setImage(tintedImage, for: .normal)
            }
        } else {
            sender.setTitleColor(UIColor(hex: 0xFFFFFF, alpha: 1), for: .normal)
            if let image = sender.imageView?.image {
                let tintedImage = image.withTintColor(UIColor(hex: 0xFFFFFF, alpha: 1), renderingMode: .alwaysOriginal)
                sender.setImage(tintedImage, for: .normal)
            }
        }
    }



    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
