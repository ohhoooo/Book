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
    private let userDefaultsManager = UserDefaultsRecentViewedBookStorage.shared
    
    private var query = ""
    private var sort = Sort.accuracy
    private var page = 1
    private var isEnd = false
    
    private var recentViewedBooks: [String] = []
    private var searchResultBooks: [Book] = []
    
    // MARK: - life cycles
    override func loadView() {
        view = self.searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureData()
        configureSearchBar()
        configureCollectionView()
    }
    
    // MARK: - methods
    private func configureData() {
        recentViewedBooks = userDefaultsManager.fetchRecentViewedBooks()
    }
    
    private func configureSearchBar() {
        self.searchView.searchBar.delegate = self
    }
    
    private func configureCollectionView() {
        self.searchView.collectionView.delegate = self
        self.searchView.collectionView.dataSource = self
        
        self.searchView.collectionView.register(RecentViewedBookCell.self, forCellWithReuseIdentifier: "RecentViewedBookCell")
        self.searchView.collectionView.register(SearchResultBookCell.self, forCellWithReuseIdentifier: "SearchResultBookCell")
        self.searchView.collectionView.register(SearchResultBookHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchResultBookHeaderView")
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
        if let query = searchBar.text, !query.isEmpty {
            self.page = 1
            self.query = query
            self.isEnd = false
            self.searchResultBooks = []
            
            fetchSearchResultBooks()
            searchBar.resignFirstResponder()
        }
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == searchResultBooks.count - 1 && isEnd == false {
            fetchSearchResultBooks()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let bookDetailVC = BookDetailViewController()
            bookDetailVC.bind(book: searchResultBooks[indexPath.row])
            
            recentViewedBooks = userDefaultsManager.saveRecentViewedBook(title: searchResultBooks[indexPath.row].title)
            searchView.collectionView.reloadData()
            
            self.present(bookDetailVC, animated: true)
        }
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SearchResultBookHeaderView", for: indexPath) as? SearchResultBookHeaderView else {
                return UICollectionReusableView()
            }
            
            if indexPath.section == 0 {
                header.prepare(text: "최근 본 책")
            } else {
                header.prepare(text: "검색 결과")
            }
            
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return recentViewedBooks.count
        } else {
            return searchResultBooks.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentViewedBookCell", for: indexPath) as? RecentViewedBookCell else {
                return UICollectionViewCell()
            }
            
            cell.bind(title: recentViewedBooks[indexPath.row])
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchResultBookCell", for: indexPath) as? SearchResultBookCell else {
                return UICollectionViewCell()
            }
            
            cell.bind(book: searchResultBooks[indexPath.row])
            
            return cell
        }
    }
}
