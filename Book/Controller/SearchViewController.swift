//
//  SearchViewController.swift
//  Book
//
//  Created by 김정호 on 5/2/24.
//

import UIKit

final class SearchViewController: UIViewController {

    // MARK: - properties
    private let searchView = SearchView()
    
    // MARK: - life cycles
    override func loadView() {
        view = self.searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - methods
}
