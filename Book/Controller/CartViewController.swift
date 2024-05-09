//
//  CartViewController.swift
//  Book
//
//  Created by 김정호 on 5/9/24.
//

import UIKit
import CoreData

final class CartViewController: UIViewController {

    // MARK: - properties
    private let cartView = CartView()
    
    // MARK: - life cycles
    override func loadView() {
        view = self.cartView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - methods
}
