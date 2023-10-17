//
//  SideMenuViewController.swift
//  TakeMeHome
//
//  Created by Алексей Шамрей on 8.02.23.
//

import UIKit
import SnapKit

final class SideMenuViewController: UIViewController {
    
    private let menuTableView = ListMenuTableView()
    
    private lazy var logOutButton: UIButton = {
        let logOutButton = UIButton()
        logOutButton.backgroundColor = .clear
        logOutButton.setTitle("Выйти из аккаунта", for: .normal)
        logOutButton.titleLabel?.font = UIFont.montseratt(ofSize: 15, weight: .medium)
        logOutButton.setTitleColor(.white, for: .normal) // Установите желаемый цвет текста
        logOutButton.layer.cornerRadius = 10
        logOutButton.layer.borderWidth = 0.5
        logOutButton.layer.borderColor = UIColor.white.cgColor
        return logOutButton
    }()

    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Menu"
        titleLabel.font = UIFont.montseratt(ofSize: 25, weight: .bold)
        titleLabel.textColor = .white
        return titleLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }

    func createUI() {
        setup()
        makeConstraints()
        createMenuTableView()
    }
    
    func setup() {
        self.view.backgroundColor = .black
        self.view.addSubview(titleLabel)
        self.view.addSubview(logOutButton)
        
    }
    
    func createMenuTableView() {
        menuTableView.backgroundColor = .clear
        self.view.addSubview(menuTableView)
        
        menuTableView.snp.makeConstraints { maker in
            maker.top.equalTo(titleLabel.snp.bottom).inset(-20)
            maker.left.right.equalToSuperview().inset(25)
            maker.height.equalToSuperview().multipliedBy(0.6)
        }
    }
    
    func makeConstraints() {
        titleLabel.snp.makeConstraints { maker in
            maker.left.top.equalTo(self.view.safeAreaLayoutGuide).inset(15)
        }
        
        logOutButton.snp.makeConstraints { maker in
            maker.left.right.bottom.equalToSuperview().inset(25)
            maker.height.equalTo(self.view.safeAreaLayoutGuide).multipliedBy(0.1)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        titleLabel.removeFromSuperview()
    }
}
