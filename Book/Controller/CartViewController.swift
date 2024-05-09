//
//  CartViewController.swift
//  Book
//
//  Created by 김정호 on 5/9/24.
//

import UIKit
import CoreData

final class CartViewController: UIViewController {
    
    // MARK: - properties
    private let cartView = CartView()
    
    private let coreDataStorage = CoreDataSavedBookStorage.shared
    
    private var books: [SavedBook] = []
    
    // MARK: - life cycles
    override func loadView() {
        view = self.cartView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureData()
        configureTableView()
    }
    
    // MARK: - methods
    private func configureData() {
        books = coreDataStorage.fetchSavedBooks()
    }
    
    private func configureTableView() {
        cartView.tableView.delegate = self
        cartView.tableView.dataSource = self
        
        cartView.tableView.register(SavedBookCell.self, forCellReuseIdentifier: "SavedBookCell")
    }
}

extension CartViewController: UITableViewDelegate {
    
}

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SavedBookCell", for: indexPath) as? SavedBookCell else {
            return UITableViewCell()
        }
        
        cell.bind(book: books[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
}
