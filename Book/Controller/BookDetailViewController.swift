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
    
    // MARK: - life cycles
    override func loadView() {
        view = self.bookDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - methods
    private func configureUI() {
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [ .large()]
        }
        sheetPresentationController?.prefersGrabberVisible = true
    }
    
    func bind(book: Book) {
        self.bookDetailView.bind(book: book)
    }
}
