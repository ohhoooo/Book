//
//  SearchResultBookCell.swift
//  Book
//
//  Created by 김정호 on 5/6/24.
//

import UIKit
import SnapKit
import Kingfisher

final class SearchResultBookCell: UICollectionViewCell {
    
    // MARK: - properties
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let authorsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: - life cycles
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.backgroundColor = .white
    }
    
    private func configureConstraints() {
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        self.addSubview(authorsLabel)
        
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.imageView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
        }
        
        authorsLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(4)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func bind(book: Book) {
        if let thumbnail = URL(string: book.thumbnail) {
            imageView.kf.setImage(with: thumbnail)
        }
        
        if !book.title.isEmpty {
            titleLabel.text = book.title
        } else {
            titleLabel.text = " "
        }
        
        if let authors = book.authors.first, !authors.isEmpty {
            authorsLabel.text = authors
        } else {
            authorsLabel.text = " "
        }
    }
}
