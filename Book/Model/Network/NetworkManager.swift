//
//  NetworkManager.swift
//  Book
//
//  Created by 김정호 on 5/1/24.
//

import Foundation

enum Sort {
    case accuracy
    case latest
}

final class NetworkManager {
    
    // MARK: - properties
    
    // singleton
    static let shared = NetworkManager()
    private init() {}
    
    // base
    private let basedUrl = "https://dapi.kakao.com/v3/search/book"
    
    // header
    private let authorization = Bundle.main.infoDictionary?["APIKey"] as! String
    
    // MARK: - methods
    func fetchBooks(query: String, sort: Sort, page: Int, completion: @escaping ((Result<Response, Error>) -> Void)) {
        guard let url = URL(string: "\(basedUrl)?query=\(query)&sort=\(Sort.latest)&page=\(page)&size=12") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue(authorization, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                print(error)
                return
            }
            
            guard let data else {
                return
            }
            
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(response))
            } catch {
                return
            }
        }
        
        task.resume()
    }
}
