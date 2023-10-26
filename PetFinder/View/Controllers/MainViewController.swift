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
    
    private lazy var rightMainButton: UIButton = {
        let rightMainButton = UIButton()
        rightMainButton.backgroundColor = .systemGray
        rightMainButton.layer.cornerRadius = 0
        return rightMainButton
    }()
    
    private lazy var numberOfAds: UILabel = {
        let numberOfAds = UILabel()
        numberOfAds.text = "Results: 0"
        numberOfAds.font = UIFont.sfProText(ofSize: 15, weight: .regular)
        
        return numberOfAds
    }()
    
    private lazy var adsLabel: UILabel = {
        let adsLabel = UILabel()
        adsLabel.text = "Объявления"
        adsLabel.font = UIFont.sfProText(ofSize: 25, weight: .bold)
        return adsLabel
    }()
    
    private lazy var adsLabelAndNumberOfAds: UIStackView = {
        let adsLabelAndNumberOfAds = UIStackView()
        adsLabelAndNumberOfAds.axis = .horizontal
        adsLabelAndNumberOfAds.distribution = .equalSpacing
        return adsLabelAndNumberOfAds
    }()
    
    private lazy var mainLabel: UILabel = {
        let mainLabel = UILabel()
        mainLabel.text = "Доска объявлений"
        mainLabel.font = UIFont.sfProText(ofSize: 24, weight: .semiBold)
        mainLabel.textColor = .black
        return mainLabel
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
        createUI()
    }
    
    func createUI() {
        setup()
        setupMainLabel()
        setupRightMainButton()
        setupSearchBarAndAdditionalSettingsStackView()
        createAnimalsCollectionView()
        setupAdsTableView()
    }
    
    
    func setupMainLabel() {
        self.view.addSubview(mainLabel)
        
        mainLabel.snp.makeConstraints { maker in
            maker.left.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            maker.top.equalTo(self.view.safeAreaLayoutGuide).inset(5)
        }
    }
    
    func setupRightMainButton() {
        self.view.addSubview(rightMainButton)
        
        rightMainButton.snp.makeConstraints { maker in
            maker.right.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            maker.top.equalTo(self.view.safeAreaLayoutGuide).inset(5)
            maker.width.equalTo(28) // Установите желаемую ширину кнопки
            maker.height.equalTo(rightMainButton.snp.width)
        }
        
        rightMainButton.layoutIfNeeded()
        
        rightMainButton.layer.cornerRadius = rightMainButton.frame.height / 2
    }
    
    func setup() {
        self.view.backgroundColor = .white
        self.hideKeyboardWhenTappedAround()
        self.view.addSubview(searchBarAndAdditionalSettings)
        self.view.addSubview(adsLabelAndNumberOfAds)
        self.view.addSubview(adsTableView)
    }
    
    func setupSearchBarAndAdditionalSettingsStackView() {
        
        let additionalSettingsButton = createAdditionalSettingsButton()
        
        searchBarAndAdditionalSettings.addArrangedSubview(createSearchBar())
        searchBarAndAdditionalSettings.addArrangedSubview(additionalSettingsButton)
        
        searchBar.widthAnchor.constraint(equalTo: searchBarAndAdditionalSettings.widthAnchor, multiplier: 0.91).isActive = true
        
        searchBarAndAdditionalSettings.snp.makeConstraints { maker in
            maker.top.equalTo(self.view.safeAreaLayoutGuide).inset(50)
            maker.left.right.equalToSuperview().inset(10)
            maker.height.equalToSuperview().multipliedBy(0.04)
        }
        searchBarAndAdditionalSettings.layoutIfNeeded()
        additionalSettingsButton.layer.cornerRadius = additionalSettingsButton.frame.width / 2
    }
    
    func createSearchBar() -> UISearchBar {
        searchBar.placeholder = "Начните поиск"
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.font = UIFont.sfProText(ofSize: 15, weight: .regular)
        return searchBar
    }
    
    func createAdditionalSettingsButton() -> UIButton {
        let additionalSettings = UIButton()
        additionalSettings.backgroundColor = .systemGray
        additionalSettings.tintColor = .white
        additionalSettings.layer.cornerRadius = 0
        
        additionalSettings.layer.cornerRadius = additionalSettings.bounds.height / 2.1
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
    
    func setupAdsTableView() {
        adsTableView.snp.makeConstraints { maker in
            maker.top.equalTo(animalsCollectionView.snp.bottom).inset(-10)
            maker.left.right.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(5)
        }
    }
    
    @objc func menuTapped () {
        sideMenuViewController = nil
    }
    
    
    @objc func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        guard let menuView = sideMenuViewController?.view else { return }
        UIView.animate(withDuration: 0.2) {
            menuView.frame.origin.x = -menuView.frame.size.width
        }
    }
}

