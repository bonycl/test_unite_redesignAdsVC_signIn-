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
    private let adsTableView = AdsTableView()
    
    
    private lazy var lineView: UIView = { 
        let lineView = UIView()
        lineView.backgroundColor = .systemGray
        lineView.layer.opacity = 0.3
        return lineView
    }()
    
    private lazy var numberOfAds: UILabel = {
        let numberOfAds = UILabel()
        numberOfAds.text = "Results: 0"
        numberOfAds.font = UIFont.montseratt(ofSize: 15, weight: .regular)
        
        return numberOfAds
    }()
    
    private lazy var adsLabel: UILabel = {
        let adsLabel = UILabel()
        adsLabel.text = "Объявления"
        adsLabel.font = UIFont.montseratt(ofSize: 25, weight: .bold)
        return adsLabel
    }()
    
    private lazy var adsLabelAndNumberOfAds: UIStackView = {
        let adsLabelAndNumberOfAds = UIStackView()
        adsLabelAndNumberOfAds.axis = .horizontal
        adsLabelAndNumberOfAds.distribution = .equalSpacing
        return adsLabelAndNumberOfAds
    }()
    
    private lazy var currentPosition: UIButton = {
        let currentPosition = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        currentPosition.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        currentPosition.setTitleColor(.black, for: .normal)
        currentPosition.setImage(UIImage(systemName: "mappin.circle.fill"), for: .normal)
        currentPosition.titleLabel?.font = UIFont.montseratt(ofSize: 20, weight: .medium)
        currentPosition.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return currentPosition
    }()
    
    private lazy var searchBarAndAdditionalSettings: UIStackView = {
        let searchBarAndAdditionalSettings = UIStackView()
        searchBarAndAdditionalSettings.axis = .horizontal
        searchBarAndAdditionalSettings.distribution = .fill
        return searchBarAndAdditionalSettings
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    private lazy var additionalSettings: UIButton = {
        let additionalSettings = UIButton()
        return additionalSettings
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCurrentPossitionButton()
        checkUserDefaultsCityName()
        createUI()
    }

    func createUI() {
        setup()
        setupSearchBarAndAdditionalSettingsStackView()
        createAnimalsCollectionView()
        setupAdsLabelAndNumberOfAds()
        setupLineView()
        setupAdsTableView()
    }
    
    func setupLineView() {
        lineView.snp.makeConstraints { maker in
            maker.top.equalTo(adsLabelAndNumberOfAds.snp.bottom).inset(-10)
            maker.left.right.equalToSuperview().inset(15)
            maker.height.equalTo(0.4)
        }
    }
    
    func setup() {
        self.view.backgroundColor = .white
        self.hideKeyboardWhenTappedAround()
        self.view.addSubview(searchBarAndAdditionalSettings)
        self.view.addSubview(adsLabelAndNumberOfAds)
        self.view.addSubview(lineView)
        self.view.addSubview(adsTableView)
    }
    
    func setupSearchBarAndAdditionalSettingsStackView() {
        
        searchBarAndAdditionalSettings.addArrangedSubview(createSearchBar())
        searchBarAndAdditionalSettings.addArrangedSubview(createAdditionalSettingsButton())
        
        searchBar.widthAnchor.constraint(equalTo: searchBarAndAdditionalSettings.widthAnchor, multiplier: 0.8).isActive = true
        
        searchBarAndAdditionalSettings.snp.makeConstraints { maker in
            maker.top.equalTo(self.view.safeAreaLayoutGuide).inset(50)
            maker.left.right.equalToSuperview().inset(10)
            maker.height.equalToSuperview().multipliedBy(0.04)
        }
    }
    
    func setupAdsLabelAndNumberOfAds() {
        adsLabelAndNumberOfAds.addArrangedSubview(adsLabel)
        adsLabelAndNumberOfAds.addArrangedSubview(numberOfAds)
        
        adsLabelAndNumberOfAds.snp.makeConstraints { maker in
            maker.top.equalTo(animalsCollectionView.snp.bottom).inset(-25)
            maker.left.right.equalTo(self.view.safeAreaLayoutGuide).inset(25)
            maker.height.equalTo(self.view.safeAreaLayoutGuide).multipliedBy(0.05)
        }
    }
    
    func createSearchBar() -> UISearchBar {
        searchBar.placeholder = "Начните поиск"
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.font = UIFont.montseratt(ofSize: 15, weight: .medium)
        
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
//        showBulletinViewController(shouldMove: true)
    }
    
    func createCurrentPossitionButton() {
        self.view.addSubview(currentPosition)
        
        currentPosition.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(50)
            maker.height.equalTo(self.view.safeAreaLayoutGuide).multipliedBy(0.05)
            maker.width.equalToSuperview().inset(20)
            maker.centerX.equalToSuperview()
        }
    }
    
    func setupAdsTableView() {
        
        adsTableView.snp.makeConstraints { maker in
            maker.top.equalTo(lineView.snp.bottom).inset(-10)
            maker.left.right.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(5)
        }
    }
    
    @objc func menuTapped () {
        sideMenuViewController = nil
        configureMenuViewController()
//        showBulletinViewController(shouldMove: true)
    }
    
    @objc func buttonTapped() {
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
    
//    func showBulletinViewController(shouldMove: Bool) {
//        if shouldMove {
//            // show
//            UIView.animate(withDuration: 0.5,
//                           delay: 0,
//                           usingSpringWithDamping: 0.8,
//                           initialSpringVelocity: 0,
//                           options: .curveEaseInOut,
//                           animations: {
//                self.sideMenuViewController.view.frame.size.width = 250
//            })
//        } else {
//            UIView.animate(withDuration: 0.5,
//                           delay: 0,
//                           usingSpringWithDamping: 0.8,
//                           initialSpringVelocity: 0,
//                           options: .curveEaseInOut,
//                           animations: {
//                self.sideMenuViewController.view.frame.size.width = 0
//            })
//        }
//    }
    
    func checkUserDefaultsCityName() {
        if userDefaults.object(forKey: cityKey) == nil {
            let cityName = "Lida, Belarus"
            userDefaults.setValue(cityName, forKey: cityKey)
            currentPosition.setTitle(cityName, for: .normal)
        } else {
            let cityName = userDefaults.object(forKey: cityKey) ?? ""
            currentPosition.setTitle(cityName as! String, for: .normal)
        }
    }
}

extension MainViewController: ChildViewControllerDelegate {
    func didDismissFormSheet() {
        checkUserDefaultsCityName()
    }
}


