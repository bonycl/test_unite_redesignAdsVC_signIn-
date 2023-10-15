//
//  PositionSelectionViewController.swift
//  PetFinder
//
//  Created by Алексей Шамрей on 15.10.23.
//

import UIKit
import SnapKit

protocol ChildViewControllerDelegate: class {
    func didDismissFormSheet()
}

final class PositionSelectionViewController: UIViewController {
    private let searchCity = UITextField()
    private let acceptCity = UIButton()
    private let textFieldAndButton = UIStackView()
    private let userDefaults = UserDefaults.standard
    private let cityKey = "city"
    
    weak var delegate: ChildViewControllerDelegate?


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        createUI()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func createUI() {
        createTextFieldAndButtonStackView()
        
    }
    
    func createTextFieldAndButtonStackView() {
        textFieldAndButton.axis = .horizontal
        textFieldAndButton.distribution = .fill
        textFieldAndButton.spacing = 10
        textFieldAndButton.addArrangedSubview(createSearchCityTextField())
        textFieldAndButton.addArrangedSubview(createAcceptCityButton())
        self.view.addSubview(textFieldAndButton)
        
        searchCity.widthAnchor.constraint(equalTo: textFieldAndButton.widthAnchor, multiplier: 0.7).isActive = true
        
        textFieldAndButton.snp.makeConstraints { maker in
            maker.left.right.equalToSuperview().inset(10)
            maker.top.equalToSuperview().inset(30)
            maker.height.equalToSuperview().multipliedBy(0.05)
        }
    }
    
    func createSearchCityTextField() -> UITextField {
        searchCity.placeholder = "Введите необходимый город"
        searchCity.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: searchCity.frame.height))
        searchCity.leftViewMode = .always
        searchCity.layer.cornerRadius = 10
        searchCity.layer.borderWidth = 0.1
        searchCity.layer.borderColor = UIColor.black.cgColor
        return searchCity
    }
    
    func createAcceptCityButton() -> UIButton {
        acceptCity.backgroundColor = .systemBlue
        acceptCity.layer.cornerRadius = 10
        acceptCity.setTitle("Принять", for: .normal)
        acceptCity.addTarget(self, action: #selector(acceptedCity), for: .touchUpInside)
        return acceptCity
    }
    
    @objc func acceptedCity() {
        guard searchCity.text != "" else {
            return
        }
        userDefaults.setValue(searchCity.text ?? "", forKey: cityKey)
        searchCity.text = ""
        dismiss(animated: true) {
                self.delegate?.didDismissFormSheet()
         }
    }
}
