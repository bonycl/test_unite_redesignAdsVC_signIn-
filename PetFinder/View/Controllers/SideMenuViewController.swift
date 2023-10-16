//
//  SideMenuViewController.swift
//  TakeMeHome
//
//  Created by Алексей Шамрей on 8.02.23.
//

import UIKit
import SnapKit

final class SideMenuViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Menu"
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
    }
    
    func setup() {
        self.view.backgroundColor = .black
        self.view.addSubview(titleLabel)
        
    }
    
    func makeConstraints() {
        titleLabel.snp.makeConstraints { maker in
            maker.left.top.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        titleLabel.removeFromSuperview()
    }
}
