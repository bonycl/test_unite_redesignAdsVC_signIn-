//
//  SceneDelegate.swift
//  PetFinder
//
//  Created by Julia on 15.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        self.window?.windowScene = windowScene
        let homeVC = CustomTabBarControllerViewController()
//        let navigationController = UINavigationController(rootViewController: MainViewController())
        self.window?.rootViewController = homeVC
        self.window?.makeKeyAndVisible()
    }
}

