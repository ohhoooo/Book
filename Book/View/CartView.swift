//
//  CartView.swift
//  Book
//
//  Created by 김정호 on 5/9/24.
//

import UIKit
import SnapKit

final class CartView: UIView {
    
    // MARK: - properties
    let allBooksDeletionButton: UIButton = {
        let button = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 15, weight: .medium), .foregroundColor: UIColor.gray]
        let attributedTitle = NSAttributedString(string: "전체 삭제", attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "담은 책"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
        return label
    }()
    
    let bookAdditionButton: UIButton = {
        let button = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 15, weight: .medium), .foregroundColor: UIColor(red: 107/255, green: 184/255, blue: 100/255, alpha: 1)]
        let attributedTitle = NSAttributedString(string: "추가", attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        return tableView
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
        self.addSubview(allBooksDeletionButton)
        self.addSubview(titleLabel)
        self.addSubview(bookAdditionButton)
        self.addSubview(tableView)
        
        allBooksDeletionButton.snp.makeConstraints {
            $0.centerY.equalTo(self.titleLabel.snp.centerY)
            $0.leading.equalToSuperview().offset(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.centerX.equalToSuperview()
        }
        
        bookAdditionButton.snp.makeConstraints {
            $0.centerY.equalTo(self.titleLabel.snp.centerY)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(self.bookAdditionButton.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
