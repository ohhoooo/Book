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
        
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureData()
        cartView.tableView.reloadData()
    }
    
    // MARK: - methods
    private func configureTableView() {
        cartView.tableView.delegate = self
        cartView.tableView.dataSource = self
        
        cartView.tableView.register(SavedBookCell.self, forCellReuseIdentifier: "SavedBookCell")
    }
    
    private func configureData() {
        books = coreDataStorage.fetchSavedBooks()
    }
}

extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteContextualAction = UIContextualAction(style: .normal, title: nil) { (_, _, success: @escaping (Bool) -> Void) in
            let alertVC = UIAlertController(title: "정말로 삭제 하시겠습니까?", message: nil, preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel)
            let checkAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
                guard let self = self else { return }
                
                coreDataStorage.deleteBook(book: books[indexPath.row]) { [weak self] result in
                    guard let self = self else { return }
                    
                    switch result {
                    case .success(let savedBooks):
                        books = savedBooks
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    case .failure(let error):
                        switch error {
                        case CoreDataError.notfoundItemError:
                            printCheckAlert(title: "해당 책을 찾을 수 없습니다.")
                        default:
                            printCheckAlert(title: "알 수 없는 오류입니다.")
                        }
                    }
                    
                    success(true)
                }
            }
            
            alertVC.addAction(checkAction)
            alertVC.addAction(cancelAction)
            
            self.present(alertVC, animated: true)
        }
        
        deleteContextualAction.backgroundColor = .systemRed
        deleteContextualAction.image = UIImage(systemName: "trash.fill")
        
        return UISwipeActionsConfiguration(actions: [deleteContextualAction])
    }
    
    func printCheckAlert(title: String) {
        let alertVC = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let checkAction = UIAlertAction(title: "확인", style: .default)
        
        alertVC.addAction(checkAction)
        
        self.present(alertVC, animated: true)
    }
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
