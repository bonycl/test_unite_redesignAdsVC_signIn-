//
//  AdsTableView.swift
//  PetFinder
//
//  Created by Алексей Шамрей on 21.10.23.
//

import UIKit

class AdsTableView: UITableView {

    private let massivePet = ["Аккаунт", "Уведомления", "Наши контакты", "FAQ"]
    
    init() {
        super.init(frame: .zero, style: .plain)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        setup()
        self.register(AdsTableViewCell.self, forCellReuseIdentifier: "AdsTableViewCell")
    }
    
    func setup() {
        self.dataSource = self
        self.delegate = self
        self.separatorStyle = .none
        self.backgroundColor = .white
    }
}

extension AdsTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AdsTableViewCell", for: indexPath) as? AdsTableViewCell else {
            fatalError("Unable to dequeue AnimalCollectionViewCell")
        }
        return configure(cell: cell, for: indexPath)
    }
    
    private func configure(cell: AdsTableViewCell, for indexPath: IndexPath) -> UITableViewCell {
        cell.createUI(text: "Бетси")
        return cell
    }
}

extension AdsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row) // Здесь можно выполнить действие, связанное с выбором строки
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          let tableViewHeight = tableView.bounds.height
          let cellHeight = tableViewHeight * 0.35 // 20% от высоты tableView
          return cellHeight
      }

    
}



