//
//  WrittenWishCell.swift
//  togalkinaPW2
//
//  Created by Тася Галкина on 20.11.2023.
//

import Foundation
import UIKit

final class NewWishCell: UITableViewCell, UITextViewDelegate {
    
    private enum Constants {
        static let wrapColor: UIColor = .white
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        static let wishLabelOffset: CGFloat = 8
        
        static let buttonRadius: CGFloat = 15
        static let buttonHeight:CGFloat = 30
        static let buttonSide:CGFloat = 20
        static let buttonBottom:CGFloat = 50
        
        static let textRadius: CGFloat = 15
    }
    
    let wishText: UITextView = UITextView()
    private let plusButton: UIButton = UIButton(type: .system)
    var addWish: ((String) -> ())?
    static let reuseId: String = "NewWishCell"
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        let wrap: UIView = UIView()
        addSubview(wrap)
        
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapRadius
        wrap.pinVertical(to: self, Constants.wrapOffsetV)
        wrap.pinHorizontal(to: self, Constants.wrapOffsetH)
        configureUIButton(wrap: wrap)
        //configureUITextView(wrap: wrap)
    }
    
    func configureUIButton(wrap: UIView) {
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        wrap.addSubview(plusButton)
        plusButton.backgroundColor = .white
        plusButton.setTitleColor(.textBlue, for: .normal)
        plusButton.setTitle("lalala", for: .normal)
        plusButton.layer.cornerRadius = Constants.buttonRadius
        
        plusButton.setHeight(Constants.buttonHeight)
        //plusButton.pinHorizontal(to: wrap, Constants.buttonSide)
        plusButton.pinVertical(to: wrap, 20)
        plusButton.pinRight(to: wrap.trailingAnchor, 20)

        
        plusButton.isHidden = false
        plusButton.isEnabled = true
        plusButton.addTarget(self, action: #selector(addNewButtonTouched), for: .touchUpInside)
    }
    
    @objc
    private func addNewButtonTouched(_ sender:UIButton) {
//        if (wishText.hasText) {
//            addWish?(wishText.text)
//            wishText.text = ""
//        }
        if let addWish = addWish {
            addWish(wishText.text)
            wishText.text = ""
        }
        print("zalupa")
    }
    
    func configureUITextView(wrap: UIView) {
        wishText.translatesAutoresizingMaskIntoConstraints = false;
        wrap.addSubview(wishText)
        wishText.backgroundColor = .white
        wishText.textColor = .black
        wishText.layer.cornerRadius = Constants.textRadius
        wishText.text = "lupazalupa"
        wishText.pinRight(to: plusButton.leadingAnchor, 20)
        wishText.pinLeft(to: wrap.leadingAnchor, 20)
        wishText.pinVertical(to: wrap, 20)
        wishText.delegate = self
        wishText.isEditable = true
    }
}
