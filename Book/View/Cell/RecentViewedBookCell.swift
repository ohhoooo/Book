//
//  RecentViewedBookCell.swift
//  Book
//
//  Created by 김정호 on 5/10/24.
//

import UIKit
import SnapKit

final class RecentViewedBookCell: UICollectionViewCell {
    
    // MARK: - properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.backgroundColor = UIColor(red: 107/255, green: 184/255, blue: 100/255, alpha: 1)
        label.clipsToBounds = true
        label.layer.cornerRadius = 12
        return label
    }()
    
    // MARK: - life cycles
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
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
        self.contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(6)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    func bind(title: String) {
        titleLabel.text = title
    }
}
