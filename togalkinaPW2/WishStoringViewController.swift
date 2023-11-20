//
//  WishStoringViewController..swift
//  togalkinaPW2
//
//  Created by Тася Галкина on 20.11.2023.
//

import Foundation
import UIKit

final class WishStoringViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .textBlue
        configureTable()
    }
    
    enum Constants {
        static let tableCornerRadius: CGFloat = 15
        static let tableOffset: CGFloat = 20
        static let numberOfSections: Int = 2
        
        static let wishesKey: String = "WishArray"
        
        static let addWishSection: Int = 0
        static let writtenWishesSection: Int = 1
        
        static let countOfWrittenWishes: Int = 1
        static let defaultRowsColors: Int = 0
    }
    
    private let table: UITableView = UITableView(frame: .zero)
    private var wishArray: [String] = ["I wish to add cells to the table"]
    private let defaults = UserDefaults.standard
    
    private func configureTable() {
        view.addSubview(table)
        table.backgroundColor = .slayPink
        table.dataSource = self
        table.separatorStyle = .none
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
            
            guard let newAddCell = cell as? NewWishCell else {return cell}
            
//            if let editingIndex = editingWishIndex {
//                newAddCell.addedText.text = wishArray[editingIndex]
//            }
            
            newAddCell.addWish = { [weak self] value in
//                if let editingIndex = self?.editingWishIndex {
//                    self?.wishArray[editingIndex] = value
//                    self?.editingWishIndex = nil
//                } else {
//                    self?.wishArray.append(value)
//                }
                self?.wishArray.append(value)
                self?.table.reloadData()
                self?.defaults.set(self?.wishArray, forKey: Constants.wishesKey)
            }
            
            return newAddCell
        } else {
            return UITableViewCell()
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.numberOfSections
    }
    
    
}

