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
        static let wrapHeight: CGFloat = 30
        
        static let buttonRadius: CGFloat = 15
        static let buttonOffsetV:CGFloat = 5
        static let buttonOffsetR:CGFloat = 5
        static let buttonWidth:CGFloat = 50
        static let buttonColor: UIColor = .textBlue
        static let buttonBackgroundColor: UIColor = .textBlue
        
        static let textRadius: CGFloat = 15
        static let textOffsetV:CGFloat = 5
        static let textOffsetR:CGFloat = 5
        static let textOffsetL:CGFloat = 1
        static let textColor: UIColor = .textBlue
        static let textBackgroundColor: UIColor = .lightText
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
        contentView.addSubview(wrap)
        
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapRadius
        wrap.pinVertical(to: self, Constants.wrapOffsetV)
        wrap.pinHorizontal(to: self, Constants.wrapOffsetH)
        wrap.setHeight(Constants.wrapHeight)
        
        configureUIButton(wrap: wrap)
        configureUITextView(wrap: wrap)
    }
    
    func configureUIButton(wrap: UIView) {
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        wrap.addSubview(plusButton)
        
        plusButton.backgroundColor = Constants.textBackgroundColor
        plusButton.setTitleColor(Constants.textColor, for: .normal)
        plusButton.setTitle("+", for: .normal)
        
        plusButton.layer.cornerRadius = Constants.buttonRadius
        plusButton.pinVertical(to: wrap, Constants.buttonOffsetV)
        plusButton.pinRight(to: wrap.trailingAnchor, Constants.buttonOffsetR)
        plusButton.setWidth(Constants.buttonWidth)
        
        plusButton.isHidden = false
        plusButton.isEnabled = true
        plusButton.addTarget(self, action: #selector(addNewButtonTouched), for: .touchUpInside)
    }
    
    @objc
    private func addNewButtonTouched(_ sender:UIButton) {
        if (wishText.hasText) {
            addWish?(wishText.text)
            wishText.text = ""
        }
    }
    
    func configureUITextView(wrap: UIView) {
        wishText.translatesAutoresizingMaskIntoConstraints = false;
        wrap.addSubview(wishText)
        wishText.backgroundColor = Constants.textBackgroundColor
        wishText.textColor = Constants.textColor
        
        wishText.layer.cornerRadius = Constants.textRadius
        wishText.pinRight(to: plusButton.leadingAnchor, Constants.textOffsetR)
        wishText.pinLeft(to: wrap.leadingAnchor, Constants.textOffsetL)
        wishText.pinVertical(to: wrap, Constants.textOffsetV)
        
        wishText.delegate = self
        wishText.isEditable = true
    }
}
