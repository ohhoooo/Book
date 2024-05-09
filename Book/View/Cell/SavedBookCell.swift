//
//  SavedBookCell.swift
//  Book
//
//  Created by 김정호 on 5/9/24.
//

import UIKit
import SnapKit

final class SavedBookCell: UITableViewCell {
    
    // MARK: - properties
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let authorsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var bookInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, authorsLabel, priceLabel])
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        return stackView
    }()
    
    // MARK: - life cycles
    override func prepareForReuse() {
        super.prepareForReuse()
        
        thumbnailImageView.image = UIImage()
        titleLabel.text = nil
        authorsLabel.text = nil
        priceLabel.text = nil
    }
    
    // MARK: - methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
        self.contentView.addSubview(thumbnailImageView)
        self.contentView.addSubview(bookInfoStackView)
        
        thumbnailImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.width.equalTo(self.snp.width).multipliedBy(0.2)
            $0.height.equalTo(self.thumbnailImageView.snp.width).multipliedBy(1.5)
        }
        
        bookInfoStackView.snp.makeConstraints {
            $0.top.equalTo(self.thumbnailImageView.snp.top)
            $0.leading.equalTo(self.thumbnailImageView.snp.trailing).offset(14)
            $0.trailing.equalToSuperview().offset(-14)
            $0.bottom.lessThanOrEqualTo(self.thumbnailImageView.snp.bottom)
        }
    }
    
    func bind(book: SavedBook) {
        if let thumbnail = book.thumbnail {
            thumbnailImageView.image = UIImage(data: thumbnail)
        }
        
        if let title = book.title, !title.isEmpty {
            titleLabel.text = book.title
        } else {
            titleLabel.text = " "
        }
        
        if let authors = book.authors, !authors.isEmpty {
            authorsLabel.text = authors
        } else {
            authorsLabel.text = " "
        }
        
        priceLabel.text = String(Int(book.price).insertCommas()) + "원"
    }
}
