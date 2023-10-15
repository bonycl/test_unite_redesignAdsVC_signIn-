//
//  MainViewController.swift
//  PetFinder
//
//  Created by Алексей Шамрей on 15.10.23.
//

import UIKit

final class MainViewController: UIViewController {

    private var sideMenuViewController: SideMenuViewController!
    private var positionSelectionViewController: PositionSelectionViewController!
    private var swipeGestureRecognizer: UISwipeGestureRecognizer?
    private let userDefaults = UserDefaults.standard
    private let cityKey = "city"
    private let animalsCollectionView = ListAnimansCollectionView()
    
    
    private let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
    private let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
    private let searchBar = UISearchBar()
    private let additionalSettings = UIButton()
    private let searchBarAndAdditionalSettings = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.hideKeyboardWhenTappedAround()
        createNavigationBar()
        checkUserDefaultsCityName()
        createUI()
    }
    
    func createUI() {
        createSearchBarAndAdditionalSettingsStackView()
        createAnimalsCollectionView()
    }
    
    func createSearchBarAndAdditionalSettingsStackView() {
        searchBarAndAdditionalSettings.axis = .horizontal
        searchBarAndAdditionalSettings.distribution = .fill
        
        self.view.addSubview(searchBarAndAdditionalSettings)
        searchBarAndAdditionalSettings.addArrangedSubview(createSearchBar())
        searchBarAndAdditionalSettings.addArrangedSubview(createAdditionalSettingsButton())
        
        searchBar.widthAnchor.constraint(equalTo: searchBarAndAdditionalSettings.widthAnchor, multiplier: 0.8).isActive = true
        
        searchBarAndAdditionalSettings.snp.makeConstraints { maker in
            maker.top.equalTo(self.view.safeAreaLayoutGuide).inset(10)
            maker.left.right.equalToSuperview().inset(10)
            maker.height.equalToSuperview().multipliedBy(0.04)
        }
    }
    
    func createSearchBar() -> UISearchBar {
        searchBar.placeholder = "Начните поиск"
        searchBar.searchBarStyle = .minimal
        
        return searchBar
    }
    
    func createAdditionalSettingsButton() -> UIButton {
        additionalSettings.backgroundColor = .systemBlue
        additionalSettings.layer.cornerRadius = 10
        additionalSettings.setImage(UIImage(systemName: "checklist"), for: .normal)
        additionalSettings.tintColor = .white
        return additionalSettings
    }
    
    
    
    
    func createAnimalsCollectionView() {
        self.view.addSubview(animalsCollectionView)
        
        animalsCollectionView.snp.makeConstraints {maker in
            maker.top.equalTo(searchBar.snp.bottom).inset(-10)
            maker.left.right.equalToSuperview().inset(10)
            maker.height.equalTo(self.view.safeAreaLayoutGuide).multipliedBy(0.1)
        }
    }
    
    @objc func handleSwipeEdgeGesture(_ gesture: UIScreenEdgePanGestureRecognizer) {
        sideMenuViewController = nil
        configureMenuViewController()
        showBulletinViewController(shouldMove: true)
    }
    
    func createNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: self, action: #selector(menuTapped))

        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(systemName: "mappin.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        titleView.addSubview(button)

        navigationItem.titleView = titleView
    }

    @objc func menuTapped () {
        sideMenuViewController = nil
        configureMenuViewController()
        showBulletinViewController(shouldMove: true)
    }
    
    @objc func buttonTapped() {
       positionSelectionViewController = PositionSelectionViewController()
        let mapPosition = PositionSelectionViewController()
        mapPosition.delegate = self
        mapPosition.modalPresentationStyle = .formSheet
        present(mapPosition, animated: true)
    }
 
    func configureMenuViewController() {
        if sideMenuViewController == nil {
            guard let navigationBarView = navigationController?.view else { return }
            
            swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
            swipeGestureRecognizer?.direction = .left
            
            sideMenuViewController = SideMenuViewController()
            view.insertSubview(sideMenuViewController.view, at: 5)
            addChild(sideMenuViewController)
            
            navigationBarView.addSubview(sideMenuViewController.view)
            sideMenuViewController.view.frame.size.width = 0
            
            sideMenuViewController.view.addGestureRecognizer(swipeGestureRecognizer!)
        }
    }

  
    @objc func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        guard let menuView = sideMenuViewController?.view else { return }
        
        UIView.animate(withDuration: 0.2) {
            menuView.frame.origin.x = -menuView.frame.size.width
        }
    }
    
    func showBulletinViewController(shouldMove: Bool) {
        if shouldMove {
            // show
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                self.sideMenuViewController.view.frame.size.width = 250
            })
        } else {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                self.sideMenuViewController.view.frame.size.width = 0
                self.sideMenuViewController.viewDidDisappear(true)
            })
        }
    }
    
    func checkUserDefaultsCityName() {

        if userDefaults.object(forKey: cityKey) == nil {
            let cityName = "Lida, Belarus"
            userDefaults.setValue(cityName, forKey: cityKey)
            button.setTitle(cityName, for: .normal)
        } else {
            let cityName = userDefaults.object(forKey: cityKey) ?? ""
            button.setTitle(cityName as! String, for: .normal)
        }
    }
}

extension MainViewController: ChildViewControllerDelegate {
    func didDismissFormSheet() {
        checkUserDefaultsCityName()
    }
}


