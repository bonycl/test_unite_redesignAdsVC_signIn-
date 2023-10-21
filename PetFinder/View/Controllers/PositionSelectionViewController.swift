//
//  PositionSelectionViewController.swift
//  PetFinder
//
//  Created by Алексей Шамрей on 15.10.23.
//

import UIKit
import SnapKit

protocol ChildViewControllerDelegate: AnyObject {
    func didDismissFormSheet()
}

final class PositionSelectionViewController: UIViewController {
    
    // MARK: - Views
    private let userDefaults = UserDefaults.standard
    private let cityKey = "city"
    weak var delegate: ChildViewControllerDelegate?
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Введите необходимый город"
        textField.font = UIFont.montseratt(ofSize: 16, weight: .semibold)
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 0.1
        textField.layer.borderColor = UIColor.black.cgColor
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always

        return textField
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.setTitle("Принять ", for: .normal)
        button.titleLabel?.font = UIFont.montseratt(ofSize: 16, weight: .medium)
        button.addTarget(self, action: #selector(acceptedCity), for: .touchUpInside)
        return button
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setup()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    private func setup() {
        setupColor()
        setupViews()
        makeConstraints()
    }
    
    private func setupViews() {
        view.addSubview(containerView)
        containerView.addSubview(textField)
        containerView.addSubview(button)
    }
    
    private func setupColor() {
        view.backgroundColor = .white
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.top.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        textField.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(4)
            make.trailing.equalToSuperview().inset(78)
        }
        button.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            make.leading.equalTo(textField.snp.trailing).offset(4)
        }
    }

    // MARK: - Methods
    
    @objc func acceptedCity() {
        guard textField.text != "" else { return }
        userDefaults.setValue(textField.text ?? "", forKey: cityKey)
        textField.text = ""
        dismiss(animated: true) {
            self.delegate?.didDismissFormSheet()
        }
    }
}
