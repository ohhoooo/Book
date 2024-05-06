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
    
    private var query = ""
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
        
        configureSearchBar()
        configureNavigationBar()
        configureCollectionView()
    }
    
    // MARK: - methods
    private func configureSearchBar() {
        self.searchView.searchBar.delegate = self
    }
    
    private func configureNavigationBar() {
        self.navigationItem.titleView = searchView.searchBar
    }
    
    private func configureCollectionView() {
        self.searchView.collectionView.delegate = self
        self.searchView.collectionView.dataSource = self
        
        self.searchView.collectionView.register(SearchResultBookCell.self, forCellWithReuseIdentifier: "SearchResultBookCell")
    }
    
    private func fetchSearchResultBooks() {
        if isEnd {
            return
        }
        
        networkManager.fetchBooks(query: query, sort: sort, page: page) { [weak self] result in
            switch result {
            case .success(let response):
                self?.page += 1
                self?.isEnd = response.meta.isEnd
                self?.searchResultBooks += response.books
                
                DispatchQueue.main.async {
                    self?.searchView.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, !text.isEmpty {
            searchBar.resignFirstResponder()
            self.query = text
            fetchSearchResultBooks()
        }
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == searchResultBooks.count - 1 && isEnd == false {
            fetchSearchResultBooks()
        }
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResultBooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchResultBookCell", for: indexPath) as? SearchResultBookCell else {
            return UICollectionViewCell()
        }
        
        cell.bind(book: searchResultBooks[indexPath.row])
        
        return cell
    }
}
