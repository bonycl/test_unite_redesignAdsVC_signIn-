//
//  CustomSearchTextField.swift
//  PetFinder
//
//  Created by Алексей Шамрей on 29.10.23.
//

import UIKit

class CustomSearchTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTextField()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 50))
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let rightViewRect = super.rightViewRect(forBounds: bounds)
        let newRightViewWidth = rightViewRect.width + 1 // Увеличиваем ширину на 1 пиксель
        let newRightViewHeight = rightViewRect.height + 1 // Увеличиваем высоту на 1 пиксель
        let newRightViewRect = CGRect(x: rightViewRect.origin.x - 15, y: rightViewRect.origin.y, width: newRightViewWidth, height: newRightViewHeight)
        return newRightViewRect
    }
    

    private func setupTextField() {
        backgroundColor = UIColor(hex: 0xfcfcfc, alpha: 0.6)
        layer.cornerRadius = 16
        font = UIFont.sfProText(ofSize: 16, weight: .regular)
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor(hex: 0xfcfcfc, alpha: 1)]
        attributedPlaceholder = NSAttributedString(string: "Начните поиск", attributes: attributes)
        textColor = .white
        font = UIFont.systemFont(ofSize: 16)
        
        // Удаление левой иконки
        leftView = nil
        leftViewMode = .never
        
        
        createRightView() // Вызываем метод createRightView()
//        createDeleteRightView()
    }

    
    func createRightView() {
        // Добавление правой иконки-лупы
        let searchImage = UIImage(systemName: "magnifyingglass")
        let searchImageView = UIImageView(image: searchImage)
        searchImageView.tintColor = .white
        
        // Устанавливаем правую иконку
        rightView = searchImageView
        
        // Устанавливаем режим отображения правой иконки
        rightViewMode = .unlessEditing
    }
    
    func createDeleteRightView() {
        let deleteImage = UIImage(systemName: "xmark.circle.fill")
        let deleteImageView = UIImageView(image: deleteImage)
        deleteImageView.tintColor = .systemGray
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clearText))
        deleteImageView.addGestureRecognizer(tapGesture)
        deleteImageView.isUserInteractionEnabled = true
        
        rightView = deleteImageView
        rightViewMode = .whileEditing
    }
    
    @objc private func clearText() {
        self.text = ""
        self.endEditing(true)
    }
    
    func getString() -> String {
        return text!
    }
}
//
//extension CustomSearchTextField: UITextFieldDelegate {
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        createDeleteRightView()
//    }
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        createRightView()
//    }
//}
