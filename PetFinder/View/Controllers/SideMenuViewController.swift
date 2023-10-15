//
//  SideMenuViewController.swift
//  TakeMeHome
//
//  Created by Алексей Шамрей on 8.02.23.
//

import UIKit
import SnapKit

class SideMenuViewController: UIViewController {
    private var titleLabel = UILabel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        createUI()
    }
    
    func createUI() {
        titleLabel.text = "Menu"
        titleLabel.textColor = .white
        self.view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { maker in
            maker.left.top.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        titleLabel.removeFromSuperview()
    }
}
