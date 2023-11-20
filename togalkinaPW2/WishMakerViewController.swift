//
//  WishMakerViewController.swift
//  togalkinaPW2
//
//  Created by Тася Галкина on 04.10.2023.
//

import Foundation
import UIKit

final class WishMakerViewController: UIViewController {
    
    enum Constants {
        static let sliderMin: Double = 0
        static let sliderMax: Double = 1
        
        static let red: String = "Red"
        static let green: String = "Green"
        static let blue: String = "Blue"
        
        static let stackRadius: CGFloat = 20
        static let stackBottom: CGFloat = -40
        static let stackLeading: CGFloat = 20
        
        static let buttonHeight:CGFloat = 30
        static let buttonSide:CGFloat = 20
        static let buttonBottom:CGFloat = 50
        static let buttonRadius:CGFloat = 15
        static let buttonText:String = "Make a wish:)"
    }
    
    
    private let addWishButton: UIButton = UIButton(type: .system)
    private let title1 = UILabel()
    private var slidersHidden = false
    private let toggleButton = UIButton(type: .system)
    private let descriptionn = UILabel()
    private let stack = UIStackView()
    private let colorCodeTextField = UITextField()
    private let applyColorButton = UIButton(type: .system)
    
    private let sliderRed = CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax)
    private let sliderGreen = CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax)
    private let sliderBlue = CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .slayPink
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .slayPink
        
        configureTitle()
        configureAddWishButton()
        configureDescription()
        configureSliders()
        configureToggleButton()
        configureRandomChange()
    }
    
    private func configureTitle() {
        title1.translatesAutoresizingMaskIntoConstraints = false
        title1.text = "WishMaker"
        title1.font = UIFont.boldSystemFont(ofSize: 32)
        title1.textColor = .textBlue
        
        view.addSubview(title1)
        NSLayoutConstraint.activate([
            title1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            title1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
        ])
    }
    
    private func configureDescription() {
        descriptionn.translatesAutoresizingMaskIntoConstraints = false
        descriptionn.text = "This app will bring you joy and will fulfill three of your wishes!\n\nThe first wish is to change the background color"
        
        descriptionn.font = UIFont.systemFont(ofSize: 16)
        descriptionn.textColor = .textBlue
        descriptionn.numberOfLines = 0
        descriptionn.lineBreakMode = .byWordWrapping
        
        view.addSubview(descriptionn)
        NSLayoutConstraint.activate([
            descriptionn.topAnchor.constraint(equalTo: title1.bottomAnchor, constant: 20),
            descriptionn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func configureSliders() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        view.addSubview(stack)
        stack.layer.cornerRadius = Constants.stackRadius
        stack.clipsToBounds = true
        stack.backgroundColor = .slayPink
        
        for slider in [sliderRed, sliderGreen, sliderBlue] {
            stack.addArrangedSubview(slider)
        }
        stack.pinCenterX(to: view)
        stack.pinHorizontal(to: view, 20)
        stack.pinBottom(to: addWishButton.topAnchor, 20)
        
        for sliderColor in [sliderRed, sliderBlue, sliderGreen] {
            sliderColor.valueChanged = { [weak self] value in
                self?.view.backgroundColor = UIColor(red: CGFloat((self?.sliderRed.slider.value)!), green: CGFloat((self?.sliderGreen.slider.value)!), blue: CGFloat((self?.sliderBlue.slider.value)!), alpha: 1)
            }
        }
        
    }
    
    @objc private func toggleSliders() {
        slidersHidden.toggle()
        
        if slidersHidden == false {
            toggleButton.setTitle("Sliders are here", for: .normal)
        } else {
            toggleButton.setTitle("Sliders are hide", for: .normal)
        }
        
        sliderRed.isHidden = slidersHidden
        sliderGreen.isHidden = slidersHidden
        sliderBlue.isHidden = slidersHidden
    }
    
    
    private func configureToggleButton() {
        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        toggleButton.setTitle("Touch me", for: .normal)
        toggleButton.setTitleColor(.textBlue, for: UIControl.State.normal)
        toggleButton.addTarget(self, action: #selector(toggleSliders), for: .touchUpInside)
        toggleButton.backgroundColor = .slayPink
        toggleButton.layer.cornerRadius = 8
        
        view.addSubview(toggleButton)
        NSLayoutConstraint.activate([
            toggleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toggleButton.topAnchor.constraint(equalTo: descriptionn.bottomAnchor, constant: 20)
        ])
    }
    
    @objc private func randomizer(){
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    private func configureRandomChange() {
        let changeButton = UIButton()
        changeButton.translatesAutoresizingMaskIntoConstraints = false
        changeButton.setTitle("Random colour change", for: .normal)
        changeButton.setTitleColor(.textBlue, for: UIControl.State.normal)
        changeButton.addTarget(self, action: #selector(randomizer), for: .touchUpInside)
        changeButton.backgroundColor = .slayPink
        changeButton.layer.cornerRadius = 8
        
        view.addSubview(changeButton)
        NSLayoutConstraint.activate([
            changeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc
    private func addWishButtonPressed() {
        present(WishStoringViewController(), animated: true)
    }
    
    private func configureAddWishButton() {
        view.addSubview(addWishButton)
        addWishButton.translatesAutoresizingMaskIntoConstraints = false
        addWishButton.setHeight(Constants.buttonHeight)
        addWishButton.pinBottom(to: view, Constants.buttonBottom)
        addWishButton.pinHorizontal(to: view, Constants.buttonSide)
        addWishButton.backgroundColor = .slayPink
        addWishButton.setTitleColor(.textBlue, for: .normal)
        addWishButton.setTitle(Constants.buttonText, for: .normal)
        
        addWishButton.layer.cornerRadius = Constants.buttonRadius
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
    }
}
