//
//  ListMenuTableViewCell.swift
//  PetFinder
//
//  Created by Алексей Шамрей on 17.10.23.
//

import UIKit

class ListMenuTableViewCell: UITableViewCell {
    
    private lazy var mainView: UIView = {
        let mainView = UIView()
        mainView.backgroundColor = .clear
        return mainView
    }()
    
    private lazy var intermediateView: UIView = {
        let intermediateView = UIView()
        intermediateView.backgroundColor = .clear
        return intermediateView
    }()
    
    private lazy var labelText: UILabel = {
        let labelText = UILabel()
        labelText.font = UIFont.montseratt(ofSize: 20, weight: .bold)
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
        self.backgroundColor = .clear
        self.layer.cornerRadius = 10
        self.addSubview(mainView)
        mainView.addSubview(labelText)
        self.addSubview(intermediateView)
    }
    
    func makeConstaints() {
        intermediateView.snp.makeConstraints { maker in
            maker.left.right.bottom.equalToSuperview()
            maker.height.equalTo(15)
        }
        
        mainView.snp.makeConstraints { maker in
            maker.left.right.top.equalToSuperview().inset(5)
            maker.bottom.equalTo(intermediateView.snp.top).inset(-15)
        }
        
        labelText.snp.makeConstraints { maker in
            maker.edges.equalToSuperview().inset(5)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
