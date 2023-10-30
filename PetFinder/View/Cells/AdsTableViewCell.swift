//
//  AdsTableViewCell.swift
//  PetFinder
//
//  Created by Алексей Шамрей on 21.10.23.
//

import UIKit
import SnapKit

class AdsTableViewCell: UITableViewCell {
        
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
    
    func createUI(text: String) {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        labelAd.text = text
        setup()
        makeConstraints()
    }
    
    func setup() {
        self.addSubview(mainView)
        self.addSubview(insertView)
        mainView.addSubview(labelAd)
        mainView.addSubview(dateCreation)
        mainView.addSubview(imagePet)
        mainView.addSubview(typeAd)
        mainView.addSubview(typeAdText)
    }

    func makeConstraints() {
        labelAd.snp.makeConstraints { maker in
            maker.top.left.equalToSuperview().inset(10)
        }
        
        dateCreation.snp.makeConstraints { maker in
            maker.top.equalTo(labelAd.snp.bottom).inset(-5)
            maker.left.equalToSuperview().inset(10)
            
        }
        
        imagePet.snp.makeConstraints { maker in
            maker.top.equalTo(dateCreation.snp.bottom).inset(-15)
            maker.left.equalToSuperview().inset(10)
            maker.width.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.35)
            maker.bottom.equalToSuperview().inset(10)
        }
         
        insertView.snp.makeConstraints { maker in
            maker.left.right.bottom.equalToSuperview()
            maker.height.equalTo(10)
        }
      
        mainView.snp.makeConstraints { maker in
            maker.left.right.top.equalToSuperview().inset(10)
            maker.bottom.equalTo(insertView.snp.top).inset(-5)
        }
        
        typeAd.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(10)
            maker.right.equalToSuperview().inset(15)
            maker.width.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.1)
            maker.height.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.15)
        }
        
        typeAdText.snp.makeConstraints { maker in
            maker.top.equalTo(typeAd.snp.bottom).inset(5)
            maker.right.equalToSuperview().inset(10)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
