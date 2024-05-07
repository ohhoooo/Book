//
//  BookDetailView.swift
//  Book
//
//  Created by 김정호 on 5/7/24.
//

import UIKit
import SnapKit
import Kingfisher

final class BookDetailView: UIView {
    
    // MARK: - properties
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let scrollContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private let authorsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.cancel.withTintColor(.white), for: .normal)
        button.backgroundColor = UIColor(red: 183/255, green: 183/255, blue: 183/255, alpha: 1)
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        button.configuration = UIButton.Configuration.plain()
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 30, bottom: 15, trailing: 30)
        return button
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 18, weight: .medium), .foregroundColor: UIColor.white]
        let attributedTitle = NSAttributedString(string: "담기", attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.backgroundColor = UIColor(red: 107/255, green: 184/255, blue: 101/255, alpha: 1)
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        button.configuration = UIButton.Configuration.plain()
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 30, bottom: 15, trailing: 30)
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cancelButton, addButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        return stackView
    }()
    
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
        self.addSubview(scrollView)
        self.addSubview(buttonStackView)
        self.scrollView.addSubview(scrollContentView)
        self.scrollContentView.addSubview(titleLabel)
        self.scrollContentView.addSubview(authorsLabel)
        self.scrollContentView.addSubview(thumbnailImageView)
        self.scrollContentView.addSubview(priceLabel)
        self.scrollContentView.addSubview(contentLabel)
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.buttonStackView.snp.top).inset(-20)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
        
        scrollContentView.snp.makeConstraints {
            $0.edges.equalTo(self.scrollView.contentLayoutGuide)
            $0.width.equalTo(self.scrollView.frameLayoutGuide)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(26)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        authorsLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        thumbnailImageView.snp.makeConstraints {
            $0.top.equalTo(self.authorsLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(90)
            $0.height.equalTo(self.thumbnailImageView.snp.width).multipliedBy(1.5)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(self.thumbnailImageView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(self.priceLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.bottom.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints {
            $0.width.equalTo(self.buttonStackView.snp.width).multipliedBy(0.25)
        }
        
        addButton.snp.makeConstraints {
            $0.width.equalTo(self.buttonStackView.snp.width).multipliedBy(0.72)
        }
    }
    
    func bind(book: Book) {
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
        
        if let thumbnail = URL(string: book.thumbnail) {
            thumbnailImageView.kf.setImage(with: thumbnail)
        }
        
        priceLabel.text = book.price.insertCommas() + "원"
        
        if !book.contents.isEmpty {
            contentLabel.attributedText = book.contents.setLineSpacing(10)
        } else {
            contentLabel.text = " "
        }
    }
}
