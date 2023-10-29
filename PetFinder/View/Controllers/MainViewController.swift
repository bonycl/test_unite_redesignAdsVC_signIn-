//
//  MainViewController.swift
//  PetFinder
//
//  Created by Алексей Шамрей on 15.10.23.
//

import UIKit

final class MainViewController: UIViewController, UISearchBarDelegate {
    
    private var sideMenuViewController: SideMenuViewController!
    private var positionSelectionViewController: PositionSelectionViewController!
    private var customSearchTextField: CustomSearchTextField!
    private var swipeGestureRecognizer: UISwipeGestureRecognizer?
    private let userDefaults = UserDefaults.standard
    private let cityKey = "city"
    private let animalsCollectionView = ListAnimansCollectionView()
    private let adsTableView = AdsTableView()
    
    private lazy var searchandNotificationView: UIView = {
        let searchandNotificationView = UIView()
        searchandNotificationView.backgroundColor = UIColor(hex: 0xfdd1a7, alpha: 1)
        
        return searchandNotificationView
    }()
    
    private lazy var notificationButton: UIButton = {
        let rightMainButton = UIButton()
        rightMainButton.backgroundColor = .clear
        rightMainButton.tintColor = .black
        rightMainButton.layer.cornerRadius = 0
        rightMainButton.setImage(UIImage(named: "bell"), for: .normal)
        return rightMainButton
    }()
    
    private lazy var adsLabel: UILabel = {
        let adsLabel = UILabel()
        adsLabel.text = "Объявления"
        adsLabel.font = UIFont.sfProText(ofSize: 25, weight: .bold)
        return adsLabel
    }()
    
    private lazy var mainLabel: UILabel = {
        let mainLabel = UILabel()
        mainLabel.text = "Доска объявлений"
        mainLabel.font = UIFont.sfProText(ofSize: 24, weight: .semiBold)
        mainLabel.textColor = .white
        return mainLabel
    }()

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
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
        createSearchandNotificationView()
        setupRightMainButton()
        createAnimalsCollectionView()
        setupAdsTableView()
    }
    
    func createSearchandNotificationView() {
        self.view.addSubview(searchandNotificationView)
        
        searchandNotificationView.snp.makeConstraints { maker in
            maker.left.right.top.equalToSuperview()
            maker.height.equalToSuperview().multipliedBy(0.2)
        }
        
        setupMainLabel()
        createSearchBar()
    }
    
    func setupMainLabel() {
        searchandNotificationView.addSubview(mainLabel)
        
        mainLabel.snp.makeConstraints { maker in
            maker.left.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            maker.top.equalTo(self.view.safeAreaLayoutGuide).inset(5)
        }
    }
    
    func setupRightMainButton() {
        self.view.addSubview(notificationButton)
        
        notificationButton.snp.makeConstraints { maker in
            maker.right.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            maker.top.equalTo(self.view.safeAreaLayoutGuide).inset(5)
            maker.width.equalTo(28) // Установите желаемую ширину кнопки
            maker.height.equalTo(notificationButton.snp.width)
        }
        
        notificationButton.layoutIfNeeded()
        
        notificationButton.layer.cornerRadius = notificationButton.frame.height / 2
    }
    
    func setup() {
        self.view.backgroundColor = .white
        self.hideKeyboardWhenTappedAround()
        self.view.addSubview(adsTableView)
    }

    func createSearchBar() {
        customSearchTextField = CustomSearchTextField()
        customSearchTextField.delegate = self
        self.view.addSubview(customSearchTextField)
        customSearchTextField.snp.makeConstraints { maker in
                 maker.top.equalTo(mainLabel.snp.bottom).inset(-15)
                 maker.left.right.equalToSuperview().inset(10)
                 maker.height.equalTo(48)
     
             }
    }
    
    func createAnimalsCollectionView() {
        self.view.addSubview(animalsCollectionView)
        
        animalsCollectionView.snp.makeConstraints {maker in
            maker.top.equalTo(searchandNotificationView.snp.bottom).inset(-10)
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

extension MainViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        customSearchTextField.createDeleteRightView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
            print("Наша строка: \(customSearchTextField.getString())")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        customSearchTextField.createRightView()
        
    }
}
