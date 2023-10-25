//
//  AdsTableViewCell.swift
//  PetFinder
//
//  Created by Алексей Шамрей on 21.10.23.
//

import UIKit
import SnapKit

class AdsTableViewCell: UITableViewCell {
    
    private lazy var  infoPetStackView: UIStackView = {
        let infoPetStackView = UIStackView()
        infoPetStackView.distribution = .equalSpacing
        infoPetStackView.axis = .vertical
        return infoPetStackView
    }()
    
    private lazy var imagePet: UIImageView = {
        let imagePet = UIImageView()
        imagePet.clipsToBounds = true

        let image = UIImage(named: "Cat")
        imagePet.image = image
        imagePet.contentMode = .scaleToFill
        imagePet.backgroundColor = .red
        imagePet.layer.cornerRadius = 10
        return imagePet
    }()
    
    private lazy var mainView: UIView = {
        let mainView = UIView()
        mainView.layer.cornerRadius = 10
        mainView.backgroundColor = .red
        return mainView
    }()
    
    private lazy var insertView: UIView = {
        let insertView = UIView()
        insertView.backgroundColor = .clear
        return insertView
    }()
    
    private lazy var labelText: UILabel = {
        let labelText = UILabel()
        labelText.font = UIFont.montseratt(ofSize: 20, weight: .bold)
        labelText.textColor = .black
        labelText.numberOfLines = 0
        return labelText
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func createUI(text: String) {
        self.selectionStyle = .none
        labelText.text = text
        setup()
        makeConstraints()
    }
    
    func setup() {
        self.addSubview(mainView)
        self.addSubview(insertView)
        mainView.addSubview(imagePet)
        mainView.addSubview(labelText)
    }
    
    func makeConstraints() {
        
        insertView.snp.makeConstraints { maker in
            maker.left.right.bottom.equalToSuperview()
            maker.height.equalTo(10)
        }
        
        mainView.snp.makeConstraints { maker in
            maker.left.right.top.equalToSuperview().inset(10)
            maker.bottom.equalTo(insertView.snp.top).inset(-5)
        }
        
        imagePet.snp.makeConstraints { maker in
            maker.left.bottom.top.equalToSuperview()
            maker.width.equalTo(imagePet.snp.height).multipliedBy(0.9)
        }
        
        labelText.snp.makeConstraints { maker in
            maker.top.right.equalToSuperview().inset(10)
            maker.left.equalTo(imagePet.snp.right).inset(-10)
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
