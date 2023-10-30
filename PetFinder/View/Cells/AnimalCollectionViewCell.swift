//
//  AnimalCollectionViewCell.swift
//  PetFinder
//
//  Created by Алексей Шамрей on 15.10.23.
//

import UIKit
import SnapKit

final class AnimalCollectionViewCell: UICollectionViewCell {
    
    private lazy var labelText: UILabel = {
        let labelText = UILabel()
        labelText.font = UIFont.sfProText(ofSize: 12, weight: .regular)
        labelText.textAlignment = .center
        labelText.textColor = .black
        return labelText
    }()
    
    private lazy var imageCell: UIImageView = {
        let imageCell = UIImageView()
        imageCell.contentMode = .scaleAspectFit
        return imageCell
    }()
    
    func createUI(text: String, imageName: String) {
        setup()
        makeConstaints()
        labelText.text = text
        imageCell.image = UIImage(named: imageName)
    }
    
    func setup() {
        self.layer.cornerRadius = 10
        self.addSubview(labelText)
        self.addSubview(imageCell)
    }
    
    func makeConstaints() {
        
        imageCell.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(10)
            maker.left.right.equalToSuperview().inset(1)
            maker.height.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.6)
        }
        labelText.snp.makeConstraints { maker in
            maker.top.equalTo(imageCell.snp.bottom).inset(-5)
            maker.left.right.equalToSuperview().inset(1)
        }
    }
}
