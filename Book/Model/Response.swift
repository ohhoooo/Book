//
//  Response.swift
//  Book
//
//  Created by 김정호 on 5/1/24.
//

import Foundation

struct Response: Codable {
    let books: [Book]
    let meta: Meta
    
    enum CodingKeys: String, CodingKey {
        case books = "documents"
        case meta
    }
}

struct Book: Codable {
    let authors: [String]
    let contents, datetime, isbn: String
    let price: Int
    let publisher: String
    let salePrice: Int
    let status: String
    let thumbnail: String
    let title: String
    let translators: [String]
    let url: String

    enum CodingKeys: String, CodingKey {
        case authors, contents, datetime, isbn, price, publisher
        case salePrice = "sale_price"
        case status, thumbnail, title, translators, url
    }
}

struct Meta: Codable {
    let isEnd: Bool
    let pageableCount, totalCount: Int

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}
