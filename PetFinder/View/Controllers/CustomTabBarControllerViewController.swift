//
//  CustomTabBarControllerViewController.swift
//  PetFinder
//
//  Created by Алексей Шамрей on 18.10.23.
//

import UIKit
import SnapKit

class CustomTabBarControllerViewController: UITabBarController {

    private let middleButtonDiameter: CGFloat = 42
    
    private lazy var leftButton: UIButton = {
        let leftButton = UIButton()
        leftButton.layer.cornerRadius = middleButtonDiameter / 2
        leftButton.backgroundColor = .systemGray
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        return leftButton
    }()
    
    private lazy var middleButton: UIButton = {
        let middleButton = UIButton()
        middleButton.layer.cornerRadius = middleButtonDiameter / 2
        middleButton.backgroundColor = .systemGray
        middleButton.translatesAutoresizingMaskIntoConstraints = false
        middleButton.addTarget(self, action: #selector(addTarget), for: .touchUpInside)
        return middleButton
    }()
    
    private lazy var rightButton: UIButton = {
        let rightButton = UIButton()
        rightButton.layer.cornerRadius = middleButtonDiameter / 2
        rightButton.backgroundColor = .systemGray
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        return rightButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        configureTabBar()
    }
    
    func setupTabBar() {
        viewControllers = [setupVC(viewController: MainViewController(), title: "Доска объявлений", image: UIImage(systemName: "house.fill")), setupVC(viewController: UIViewController(), title: "Создать объявление", image: nil), setupVC(viewController: ProfileViewController(), title: "Профиль", image: UIImage(systemName: "person.fill"))]
    }
    
    private func setupVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        let font = UIFont.sfProText(ofSize: 11, weight: .regular)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]

        viewController.tabBarItem.title = title
        viewController.tabBarItem.setTitleTextAttributes(attributes, for: .normal)
        viewController.tabBarItem.image = image
        return viewController
    }
    
    func configureTabBar() {
        
        tabBar.addSubview(middleButton)

        middleButton.snp.makeConstraints { maker in
            maker.height.equalTo(middleButtonDiameter)
            maker.width.equalTo(middleButtonDiameter)
            maker.centerX.equalTo(tabBar.snp.centerX)
            maker.top.equalTo(tabBar.snp.top).offset(-10)
        }
        
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .systemGray
        tabBar.backgroundColor = .clear
    }
    
    @objc
    func addTarget() {
        print(1)
    }
}
