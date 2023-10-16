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
        labelText.font = UIFont(name: "Geologica", size: 15.0)
        labelText.textAlignment = .center
        labelText.textColor = .white
        return labelText
    }()
    
    func createUI(text: String) {
        setup()
        makeConstaints()
        labelText.text = text
    }
    
    func setup() {
        self.backgroundColor = .systemGray
        self.layer.cornerRadius = 10
        self.addSubview(labelText)
    }
    
    func makeConstaints() {
        labelText.snp.makeConstraints { maker in
            maker.edges.equalToSuperview().inset(5)
        }
    }
}
