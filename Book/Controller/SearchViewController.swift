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
    
    private let networkManager = NetworkManager.shared
    private var sort = Sort.accuracy
    private var page = 1
    private var isEnd = false
    
    private var searchResultBooks: [Book] = []
    
    // MARK: - life cycles
    override func loadView() {
        view = self.searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    // MARK: - methods
    private func configureNavigationBar() {
        self.navigationItem.titleView = searchView.searchBar
    }
    
    private func fetchSearchResultBooks(query: String) {
        if isEnd {
            return
        }
        
        networkManager.fetchBooks(query: query, sort: sort, page: page) { [weak self] result in
            switch result {
            case .success(let response):
                self?.isEnd = response.meta.isEnd
                self?.searchResultBooks += response.books
                
                DispatchQueue.main.async {
                    self?.searchView.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        page += 1
    }
}
