//
//  WishStoringViewController..swift
//  togalkinaPW2
//
//  Created by Тася Галкина on 20.11.2023.
//

import Foundation
import UIKit

final class WishStoringViewController: UIViewController, UITableViewDelegate {
    override func viewDidLoad() {
        view.backgroundColor = .textBlue
        configureTable()
        
        if let savedWishes = defaults.stringArray(forKey: Constants.wishesKey) {
            wishArray = savedWishes
            table.reloadData()
        }
    }
    
    enum Constants {
        static let tableCornerRadius: CGFloat = 15
        static let tableOffset: CGFloat = 20
        static let numberOfSections: Int = 2
        
        static let wishesKey: String = "WishArray"
        
        static let writtenWishesSection: Int = 1
    }
    
    private let table: UITableView = UITableView(frame: .zero)
    private var wishArray: [String] = ["I wish to add cells to the table"]
    private let defaults = UserDefaults.standard
    
    private func configureTable() {
        view.addSubview(table)
        table.backgroundColor = .slayPink
        table.dataSource = self
        table.separatorStyle = .none
        table.delegate = self
        table.layer.cornerRadius = Constants.tableCornerRadius
        table.pin(to: view, Constants.tableOffset)
        table.register(NewWishCell.self, forCellReuseIdentifier: NewWishCell.reuseId)
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        
    }
}

extension WishStoringViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return wishArray.count
        } else if section == 0 {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: WrittenWishCell.reuseId,
                for: indexPath
            )
            
            guard let wishCell = cell as? WrittenWishCell else { return cell }
            
            wishCell.configure(with: wishArray[indexPath.row])
            
            return wishCell
        } else if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NewWishCell.reuseId, for: indexPath)
            
            guard let newWishCell = cell as? NewWishCell else {return cell}
            
            
            newWishCell.addWish = { [weak self] value in
                self?.wishArray.append(value)
                self?.table.reloadData()
                self?.defaults.set(self?.wishArray, forKey: Constants.wishesKey)
            }
            return newWishCell
        } else {
            return UITableViewCell()
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            wishArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            defaults.set(wishArray, forKey: Constants.wishesKey)
        }
    }
    
    func editCell(at indexPath: IndexPath, with newWish: String) {
        wishArray[indexPath.row] = newWish
        table.reloadRows(at: [indexPath], with: .automatic)
        defaults.set(wishArray, forKey: Constants.wishesKey)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == Constants.writtenWishesSection {
            let currentWish = wishArray[indexPath.row]
            
            let alertController = UIAlertController(title: "Edit you wish:)", message: nil, preferredStyle: .alert)
            alertController.addTextField { textField in
                textField.text = currentWish
            }
            
            let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
                guard let textField = alertController.textFields?.first, let newWish = textField.text else { return }
                self?.editCell(at: indexPath, with: newWish)
            }
            alertController.addAction(saveAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }
}

