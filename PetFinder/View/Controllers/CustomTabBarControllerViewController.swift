//
//  CustomTabBarControllerViewController.swift
//  PetFinder
//
//  Created by Алексей Шамрей on 18.10.23.
//

import UIKit
import SnapKit
//import STTabbar

class CustomTabBarControllerViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        configureTabBar()
        let customTabBar = STTabbar()
        setValue(customTabBar, forKey: "tabBar")
        customTabBar.centerButtonColor = UIColor(hex: 0x8965C3, alpha: 1)
        customTabBar.buttonImage = UIImage(named: "createAd")
        customTabBar.centerButtonHeight = 48
        customTabBar.padding = 5
        customTabBar.tabbarColor = UIColor(hex: 0xfcfcfc, alpha: 1)
        customTabBar.unselectedItemColor = UIColor(hex: 0x8d8d8d, alpha: 1)
    }
    
    func setupTabBar() {
        
        let mainViewController = setupVC(viewController: MainViewController(), title: "Объявления", image: setupImage(named: "clipboard"))
        
        let createViewController = setupVC(viewController: UIViewController(), title: "Сервисы", image: setupImage(named: "services"))
        let nocreateViewController = setupVC(viewController: UIViewController(), title: "", image: nil)
        let profileViewController = setupVC(viewController: ProfileViewController(), title: "Избранное", image: setupImage(named: "heart"))
        let createViewControllerS = setupVC(viewController: UIViewController(), title: "Профиль", image: setupImage(named: "profile"))
        
        // Ограничиваем количество отображаемых контроллеров в таб-баре
        let visibleViewControllers = [mainViewController, createViewController, nocreateViewController, profileViewController, createViewControllerS]
        viewControllers = visibleViewControllers
    }

    func setupImage(named: String) -> UIImage {
        let image = UIImage(named: named)
        return UIImage(cgImage: (image?.cgImage!)!, scale: 12, orientation: image!.imageOrientation)
    }
    
    private func setupVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        let font = UIFont.sfProText(ofSize: 10, weight: .regular)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]

        viewController.tabBarItem.title = title
        viewController.tabBarItem.setTitleTextAttributes(attributes, for: .normal)
        viewController.tabBarItem.image = image
        return viewController
    }
    
    func configureTabBar() {
        tabBar.tintColor = UIColor(hex: 0x8965C3, alpha: 1)
        tabBar.backgroundColor = UIColor(hex: 0xfcfcfc, alpha: 1)
    }
    
    @objc
    func addTarget() {
        print(1)
    }
}
