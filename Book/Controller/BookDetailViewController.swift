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
    }
    
    // MARK: - methods
}
