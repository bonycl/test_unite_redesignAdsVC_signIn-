//
//  CustomTabBarControllerViewController.swift
//  PetFinder
//
//  Created by Алексей Шамрей on 18.10.23.
//

import UIKit

class CustomTabBarControllerViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        configureTabBar()
    }
    
    func setupTabBar() {
        viewControllers = [setupVC(viewController: MainViewController(), title: "Доска объявлений", image: UIImage(systemName: "house.fill")), setupVC(viewController: SettingsViewController(), title: "Настройки", image: UIImage(systemName: "gearshape")), setupVC(viewController: ProfileViewController(), title: "Профиль", image: UIImage(systemName: "person.fill"))]
    }
    
    private func setupVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    func configureTabBar() {
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: positionOnX, y: tabBar.bounds.minY - positionOnY, width: width, height: height), cornerRadius: 10)
    
        
        roundLayer.path = bezierPath.cgPath
        roundLayer.fillColor = UIColor.black.cgColor
        roundLayer.opacity = 0.5
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 1
        tabBar.itemPositioning = .centered
        
        tabBar.tintColor = .tabBarAccent
        tabBar.unselectedItemTintColor = .tabBarItemLight
        tabBar.backgroundColor = .clear
    }
}
