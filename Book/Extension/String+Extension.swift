//
//  String+Extension.swift
//  Book
//
//  Created by 김정호 on 5/7/24.
//

import UIKit

extension String {
    func setLineSpacing(_ spacing: CGFloat) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        
        return NSAttributedString(
            string: self,
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        )
    }
}
