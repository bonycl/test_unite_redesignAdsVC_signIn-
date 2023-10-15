//
//  ListAnimansCollectionView.swift
//  PetFinder
//
//  Created by Алексей Шамрей on 15.10.23.
//

import UIKit
import SnapKit

class ListAnimansCollectionView: UICollectionView {
    
    private let massivePet = ["Все", "Собаки", "Кошки", "Птицы", "Прочее"]
    private var selectedCell = [IndexPath]()
    
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.dataSource = self
        self.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false

        self.collectionViewLayout = layout
        
        self.register(AnimalCollectionViewCell.self, forCellWithReuseIdentifier: "AnimalCollectionViewCell")
    }
}

// Расширение для реализации методов UICollectionViewDataSource
extension ListAnimansCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return massivePet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimalCollectionViewCell", for: indexPath) as? AnimalCollectionViewCell else {
            fatalError("Unable to dequeue AnimalCollectionViewCell")
        }
        return configure(cell: cell, for: indexPath)
    }
    
    private func configure(cell: AnimalCollectionViewCell, for indexPath: IndexPath) -> UICollectionViewCell {
        cell.createUI(text: massivePet[indexPath.row])
        
        if indexPath.row == 0 && selectedCell.isEmpty {
            cell.backgroundColor = .systemBlue
        }
        
        if selectedCell.contains(indexPath) {
            cell.backgroundColor = .systemBlue
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        
        for i in 0..<collectionView.numberOfItems(inSection: indexPath.section) {
            let indexPath = IndexPath(item: i, section: indexPath.section)
            if let cell = collectionView.cellForItem(at: indexPath) {
                cell.backgroundColor = .systemGray
            }
        }
        
        cell.backgroundColor = .systemBlue
        selectedCell.removeAll()
        selectedCell.append(indexPath)
        
    }
}


extension ListAnimansCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let itemWidth = collectionViewWidth * 0.2 // 10% от ширины collectionView
        let itemHeight = itemWidth / 1.5 // Предполагаем, что ячейка квадратная
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

