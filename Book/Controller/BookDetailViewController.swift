//
//  BookDetailViewController.swift
//  Book
//
//  Created by 김정호 on 5/7/24.
//

import UIKit

final class BookDetailViewController: UIViewController {
    
    // MARK: - properties
    private let bookDetailView = BookDetailView()
    
    private let coreDataStorage = CoreDataSavedBookStorage.shared
    
    private var book: Book?
    
    // MARK: - life cycles
    override func loadView() {
        view = self.bookDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureAddTarget()
    }
    
    // MARK: - methods
    private func configureUI() {
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [ .large()]
        }
        sheetPresentationController?.prefersGrabberVisible = true
    }
    
    private func configureAddTarget() {
        bookDetailView.cancelButton.addTarget(self, action: #selector(didTappedCancelButton), for: .touchUpInside)
        bookDetailView.addButton.addTarget(self, action: #selector(didTappedAddButton), for: .touchUpInside)
    }
    
    @objc private func didTappedCancelButton() {
        self.dismiss(animated: true)
    }
    
    @objc private func didTappedAddButton() {
        
    }
    
    func bind(book: Book) {
        self.bookDetailView.bind(book: book)
    }
}
