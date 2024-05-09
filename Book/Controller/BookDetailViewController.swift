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
        let alertVC = UIAlertController(title: "정말로 담으시겠습니까?", message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let addAction = UIAlertAction(title: "담기", style: .default) { [weak self] _ in
            guard let self = self else { return }
            
            if let book = book {
                let thumbnail = bookDetailView.thumbnailImageView.image?.pngData()
                
                coreDataStorage.saveBook(book: book, thumbnail: thumbnail) { [weak self] result in
                    guard let self = self else { return }
                    
                    switch result {
                    case .success(_):
                        printCheckAlert(title: "성공적으로 담았습니다.")
                    case .failure(let error):
                        switch error {
                        case CoreDataError.existingItemError:
                            printCheckAlert(title: "이미 담은 책입니다.")
                        default:
                            printCheckAlert(title: "알 수 없는 오류입니다.")
                        }
                    }
                }
            }
        }
        
        alertVC.addAction(cancelAction)
        alertVC.addAction(addAction)
        
        self.present(alertVC, animated: true)
    }
    
    func printCheckAlert(title: String) {
        let alertVC = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let checkAction = UIAlertAction(title: "확인", style: .default) { _ in
            self.dismiss(animated: true)
        }
        
        alertVC.addAction(checkAction)
        
        self.present(alertVC, animated: true)
    }
    
    func bind(book: Book) {
        self.book = book
        self.bookDetailView.bind(book: book)
    }
}
