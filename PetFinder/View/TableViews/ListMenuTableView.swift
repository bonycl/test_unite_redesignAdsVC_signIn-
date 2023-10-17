//
//  ListMenuTableView.swift
//  PetFinder
//
//  Created by Алексей Шамрей on 17.10.23.
//

import UIKit

class ListMenuTableView: UITableView {
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
        self.register(ListMenuTableViewCell.self, forCellReuseIdentifier: "ListMenuTableViewCell")
    }
    
    func setup() {
        self.dataSource = self
    }
}

extension ListMenuTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        massivePet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListMenuTableViewCell", for: indexPath) as? ListMenuTableViewCell else {
            fatalError("Unable to dequeue AnimalCollectionViewCell")
        }
        return configure(cell: cell, for: indexPath)
    }
    
    private func configure(cell: ListMenuTableViewCell, for indexPath: IndexPath) -> UITableViewCell {
        cell.createUI(text: massivePet[indexPath.row])
        
        return cell
    }
    
    
    
}
