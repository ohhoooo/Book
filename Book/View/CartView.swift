//
//  CartView.swift
//  Book
//
//  Created by 김정호 on 5/9/24.
//

import UIKit

final class CartView: UIView {
    
    // MARK: - properties
    
    // MARK: - methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.backgroundColor = .white
    }
}
