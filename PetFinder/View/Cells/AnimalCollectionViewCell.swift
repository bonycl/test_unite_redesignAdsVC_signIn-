//
//  AnimalCollectionViewCell.swift
//  PetFinder
//
//  Created by Алексей Шамрей on 15.10.23.
//

import UIKit
import SnapKit

class AnimalCollectionViewCell: UICollectionViewCell {
    let labelText = UILabel()
    
    func createUI(text: String) {
        self.backgroundColor = .systemGray
        self.layer.cornerRadius = 10
        
        labelText.text = text
        labelText.font = UIFont(name: "HelveticaNeue-Bold", size: 15.0)
        labelText.textAlignment = .center
        labelText.textColor = .white
        self.addSubview(labelText)
        
        labelText.snp.makeConstraints { maker in
            maker.edges.equalToSuperview().inset(5)
        }
    }
    
    func coloringCell() {
        self.backgroundColor = .systemBlue
    }
}
